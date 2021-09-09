#include "common.h"
#include "trayicon.h"

extern IAvnTrayIcon* CreateTrayIcon(IAvnTrayIconEvents* cb)
{
    @autoreleasepool
    {
        return new AvnTrayIcon(cb);
    }
}

AvnTrayIcon::AvnTrayIcon(IAvnTrayIconEvents* events)
{
    _events = events;
    
    _native = [[NSStatusBar systemStatusBar] 	statusItemWithLength: NSSquareStatusItemLength];
}

HRESULT AvnTrayIcon::SetIcon (void* data, size_t length)
{
    START_COM_CALL;
    
    @autoreleasepool
    {
        if(data != nullptr)
        {
            NSData *imageData = [NSData dataWithBytes:data length:length];
            NSImage *image = [[NSImage alloc] initWithData:imageData];
            
            NSSize originalSize = [image size];
             
            NSSize size;
            size.height = [[NSFont menuFontOfSize:0] pointSize] * 1.333333;
            
            auto scaleFactor = size.height / originalSize.height;
            size.width = originalSize.width * scaleFactor;
            
            [image setSize: size];
            [_native setImage:image];
        }
        else
        {
            [_native setImage:nullptr];
        }
        return S_OK;
    }
}

HRESULT AvnTrayIcon::SetMenu (IAvnMenu* menu)
{
    START_COM_CALL;
    
    @autoreleasepool
    {
        
    }
    
    return  S_OK;
}
