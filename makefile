DESTDIR =
LIBDIR  = /lib
MODDIR  = $(LIBDIR)/dracut/modules.d

install:
	install -d $(DESTDIR)$(MODDIR)/95aoe
	install modules.d/95aoe/* $(DESTDIR)/$(MODDIR)/95aoe

include makefile.fedora
