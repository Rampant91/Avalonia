using System;
using System.Collections.Generic;
using Avalonia.Platform;
using Avalonia.Skia;
using Avalonia.Reactive;
using SkiaSharp;

namespace Avalonia.Browser.Skia
{
    public class BrowserSkiaGpu : ISkiaGpu
    {
        // TODO
        public GRContext GrContext => throw new NotSupportedException();

        public ISkiaGpuRenderTarget? TryCreateRenderTarget(IEnumerable<object> surfaces)
        {
            foreach (var surface in surfaces)
            {
                if (surface is BrowserSkiaSurface browserSkiaSurface)
                {
                    return new BrowserSkiaGpuRenderTarget(browserSkiaSurface);
                }
            }

            return null;
        }

        public ISkiaSurface? TryCreateSurface(PixelSize size, GRSurfaceOrigin? origin)
        {
            return null;
        }

        public void Dispose()
        {
            
        }

	public object? TryGetFeature(Type t) => null;
        
        public bool IsLost => false;
        
        public IDisposable EnsureCurrent()
        {
            return Disposable.Empty;
        }
    }

    class BrowserSkiaGraphics : IPlatformGraphics
    {
        private BrowserSkiaGpu _skia = new();
        public bool UsesSharedContext => true;
        public IPlatformGraphicsContext CreateContext() => throw new NotSupportedException();

        public IPlatformGraphicsContext GetSharedContext() => _skia;
    }
}
