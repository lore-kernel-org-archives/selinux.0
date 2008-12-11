Date: Thu, 11 Dec 2008 20:54:32 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: libvir-list@redhat.com, Daniel J Walsh <dwalsh@redhat.com>,
        Daniel Veillard <veillard@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [RFC] sVirt 0.20
Message-ID: <20081211205431.GI4604@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <alpine.LRH.1.10.0812111548490.23768@tundra.namei.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.1.10.0812111548490.23768@tundra.namei.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Dec 11, 2008 at 04:00:27PM +1100, James Morris wrote:
> * Introduced the concept of a "security model", to more easily distinguish
>   between security models and labels in the API.
> 
> * The security model and DOI attributes are now properties of the hypervisor
>   (instead of the domain label), and included in its host capabilities,
>   e.g.:
>   
>     <capabilities>
>         <host>
>             <cpu>
>                 <arch>x86_64</arch>
>             </cpu>
>             <secmodel>
>                 <model>selinux</model>
>                 <doi>0</doi>
>             </secmodel>
>         </host>
>         ....
>     </capabilities>
> 
>   Implicit here is the assumption that each hypervisor may only be
>   associated with one security model.
>   
> * Integrated security model support into "virsh capabilities".
> 
> * The domain configuration label is now of the form:
> 
>     <domain> 
>         ....
>         <seclabel model='selinux'>
>             <label>system_u:system_r:virtd_t:s0</label>
>         </seclabel>
>     </domain>


I like this style of XML for domain/capabilties now.

> * The model attribute of the seclabel element above is validated against the
>   host security model at runtime.
>   
> * The output of "virsh dominfo" for a running labeled domain is now as
>   follows:
>   
>   # dominfo sys1
>   Id:             1
>   Name:           sys1
>   UUID:           fa3c8e06-0877-2a08-06fd-f2479b7bacb0
>   OS Type:        hvm
>   Security model: selinux
>   Security DOI:   0

I almost missed those two lines - they should probably be moved
down to be immediately above 'Security label' printout.

>   State:          running
>   CPU(s):         1
>   CPU time:       24.9s
>   Max memory:     524288 kB
>   Used memory:    524288 kB
>   Autostart:      disable
>   Security label: system_u:system_r:virtd_t:s0 (enforcing)



> diff --git a/autobuild.sh b/autobuild.sh
> index e5d8554..bee3f34 100755
> --- a/autobuild.sh
> +++ b/autobuild.sh
> @@ -14,10 +14,18 @@ rm -rf coverage
>  #mkdir build
>  #cd build
>  
> +SELINUXENABLED=/usr/sbin/selinuxenabled
> +
> +if [ -x $SELINUXENABLED ] && $SELINUXENABLED ; then
> +    WITH_SELINUX="--with-selinux=yes"
> +else
> +    WITH_SELINUX=""
> +fi
> +
>  ./autogen.sh --prefix="$AUTOBUILD_INSTALL_ROOT" \
>    --enable-test-coverage \
>    --enable-compile-warnings=error \
> -  --with-xen-proxy
> +  --with-xen-proxy $WITH_SELINUX

Was there a particular need to for this ? If --with-selinux is omitted
then, it'lluse CHECK_LIB/HEADER to automatically detect presence of
libselinux and turn it on if found, so it should 'do the right thing'
without flags.

> --- a/include/libvirt/libvirt.h
> +++ b/include/libvirt/libvirt.h
> @@ -111,6 +111,69 @@ typedef enum {
>  } virDomainCreateFlags;
>  
>  /**
> + * VIR_SECLABEL_LABEL_BUFLEN:
> + *
> + * Macro providing the maximum length of the virDomainSecLabel
> + * label string.  Note that this value is based on that used
> + * by Labeled NFS.
> + */
> +#define VIR_SECLABEL_LABEL_BUFLEN (4096 + 1)
> +
> +/**
> + * virDomainSecLabel:
> + *
> + * a virDomainSecLabel is a structure filled by virDomainGetSecLabel(),
> + * providing the security label and associated attributes for the specified
> + * domain.
> + *
> + */
> +typedef struct _virDomainSecLabel {
> +    char label[VIR_SECLABEL_LABEL_BUFLEN];      /* security label string */
> +    int enforcing;                              /* 1 if security policy is being enforced for domain */
> +} virDomainSecLabel;

I think we should name this just

  virSecurityLabel

Just in case we decide we want to re-use this type for security labelling
of non-Domain objects in the future.

> +
> +/**
> + * virDomainSecLabelPtr:
> + *
> + * a virDomainSecLabelPtr is a pointer to a virDomainSecLabel.
> + */
> +typedef virDomainSecLabel *virDomainSecLabelPtr;
> +
> +/**
> + * VIR_SECLABEL_MODEL_BUFLEN:
> + *
> + * Macro providing the maximum length of the virDomainSecModel model string.
> + */
> +#define VIR_SECLABEL_MODEL_BUFLEN (256 + 1)
> +
> +/**
> + * VIR_SECLABEL_DOI_BUFLEN:
> + *
> + * Macro providing the maximum length of the virDomainSecModel doi string.
> + */
> +#define VIR_SECLABEL_DOI_BUFLEN (256 + 1)
> +
> +/**
> + * virDomainSecModel:
> + *
> + * a virDomainSecModel is a structure filled by virDomainGetSecModel(),
> + * providing the per-hypervisor security model and DOI attributes for the
> + * specified domain.
> + *
> + */
> +typedef struct _virDomainSecModel {
> +    char model[VIR_SECLABEL_MODEL_BUFLEN];      /* security model string */
> +    char doi[VIR_SECLABEL_DOI_BUFLEN];          /* domain of interpetation */
> +} virDomainSecModel;

Likewise probably best to call if virSecurityModel for sake of
future proofing.

> +
> +/**
> + * virDomainSecModelPtr:
> + *
> + * a virDomainSecModelPtr is a pointer to a virDomainSecModel.
> + */
> +typedef virDomainSecModel *virDomainSecModelPtr;
> +
> +/**
>   * virNodeInfoPtr:
>   *
>   * a virNodeInfo is a structure filled by virNodeGetInfo() and providing
> @@ -504,6 +567,10 @@ int                     virDomainSetMaxMemory   (virDomainPtr domain,
>  int                     virDomainSetMemory      (virDomainPtr domain,
>                                                   unsigned long memory);
>  int                     virDomainGetMaxVcpus    (virDomainPtr domain);
> +int                     virDomainGetSecLabel	(virDomainPtr domain,
> +                                                 virDomainSecLabelPtr seclabel);
> +int                     virDomainGetSecModel	(virDomainPtr domain,
> +                                                virDomainSecModelPtr secmodel);

I'm leaning two ways on this. On the one hand I could see the
virDomainGetSecModel being done against the node to match the
fact that we record it in the node capabilities XML, so perhaps
virNodeGetSecurityModel(virConnectPtr).

On the other hand, we already have this info against the node,
and conceivably you could have a domain configured with a model
that doesn't match the node's model, so an explicit per-domain
call is right. In that scenario, could we just put the security
model data into the security label struct and have a single API


> diff --git a/qemud/Makefile.am b/qemud/Makefile.am
> index 8cb0847..9db9ee8 100644
> --- a/qemud/Makefile.am
> +++ b/qemud/Makefile.am
> @@ -122,6 +122,7 @@ libvirtd_LDADD += ../src/libvirt_driver_nodedev.la
>  endif
>  endif
>  
> +libvirtd_LDADD += ../src/libvirt_driver_seclabel.la
>  libvirtd_LDADD += ../src/libvirt.la
>  
>  if HAVE_POLKIT
> diff --git a/qemud/remote.c b/qemud/remote.c
> index 0488e6c..ab2d754 100644
> --- a/qemud/remote.c
> +++ b/qemud/remote.c
> @@ -1319,6 +1319,88 @@ remoteDispatchDomainGetMaxVcpus (struct qemud_server *server ATTRIBUTE_UNUSED,
>  }
>  
>  static int
> +remoteDispatchDomainGetSeclabel(struct qemud_server *server ATTRIBUTE_UNUSED,
> +                                struct qemud_client *client ATTRIBUTE_UNUSED,
> +                                virConnectPtr conn,
> +                                remote_error *rerr,
> +                                remote_domain_get_seclabel_args *args,
> +                                remote_domain_get_seclabel_ret *ret)
> +{
> +    virDomainPtr dom;
> +    virDomainSecLabel seclabel;
> +
> +    dom = get_nonnull_domain(conn, args->dom);
> +    if (dom == NULL) {
> +        remoteDispatchFormatError(rerr, "%s", _("domain not found"));
> +        return -2;
> +    }
> +
> +    memset(&seclabel, 0, sizeof seclabel);
> +
> +    if (virDomainGetSecLabel(dom, &seclabel) == -1) {
> +        virDomainFree(dom);
> +        remoteDispatchFormatError(rerr, "%s", _("unable to get security label"));
> +        return -1;
> +    }
> +
> +    ret->label.label_len = strlen(seclabel.label) + 1;
> +    if (VIR_ALLOC_N(ret->label.label_val, ret->label.label_len) < 0) {
> +        virDomainFree (dom);
> +        remoteDispatchFormatError(rerr, "%s", strerror (errno));
> +        return -2;
> +    }
> +    strcpy(ret->label.label_val, seclabel.label);
> +    ret->enforcing = seclabel.enforcing;
> +
> +    virDomainFree(dom);
> +    return 0;
> +}
> +
> +static int
> +remoteDispatchDomainGetSecmodel(struct qemud_server *server ATTRIBUTE_UNUSED,
> +                                struct qemud_client *client ATTRIBUTE_UNUSED,
> +                                virConnectPtr conn,
> +                                remote_error *rerr,
> +                                remote_domain_get_secmodel_args *args,
> +                                remote_domain_get_secmodel_ret *ret)
> +{
> +    virDomainPtr dom;
> +    virDomainSecModel secmodel;
> +
> +    dom = get_nonnull_domain(conn, args->dom);
> +    if (dom == NULL) {
> +        remoteDispatchFormatError(rerr, "%s", _("domain not found"));
> +        return -2;
> +    }
> +
> +    memset(&secmodel, 0, sizeof secmodel);
> +    if (virDomainGetSecModel(dom, &secmodel) == -1) {
> +        virDomainFree(dom);
> +        remoteDispatchFormatError(rerr, "%s", _("unable to get security model"));
> +        return -1;
> +    }
> +
> +    ret->model.model_len = strlen(secmodel.model) + 1;
> +    if (VIR_ALLOC_N(ret->model.model_val, ret->model.model_len) < 0) {
> +        virDomainFree(dom);
> +        remoteDispatchFormatError(rerr, "%s", strerror (errno));
> +        return -2;
> +    }
> +    strcpy(ret->model.model_val, secmodel.model);
> +
> +    ret->doi.doi_len = strlen(secmodel.doi) + 1;
> +    if (VIR_ALLOC_N(ret->doi.doi_val, ret->doi.doi_len) < 0) {
> +        virDomainFree(dom);
> +        remoteDispatchFormatError(rerr, "%s", strerror (errno));
> +        return -2;
> +    }
> +    strcpy(ret->doi.doi_val, secmodel.doi);
> +
> +    virDomainFree(dom);
> +    return 0;
> +}

Since the per-call API handlers are now 100% responsible for serializing
the errors onto the wire, there's no need for the -1, -2 distinction in
return values anymore - just change them all to -1.

For failures in VIR_ALLOC and strdup, you can call the  convenience
function remoteDispatchOOMError(), rather than serializing an errno
based string, since we track OOM with an explicit error code.


> diff --git a/src/Makefile.am b/src/Makefile.am
> index c32a1d4..076ef85 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -134,7 +134,7 @@ UML_DRIVER_SOURCES =						\
>  NETWORK_DRIVER_SOURCES =					\
>  		network_driver.h network_driver.c
>  
> -# And finally storage backend specific impls
> +# Storage backend specific impls
>  STORAGE_DRIVER_SOURCES =					\
>  		storage_driver.h storage_driver.c		\
>  		storage_backend.h storage_backend.c
> @@ -159,6 +159,12 @@ STORAGE_DRIVER_DISK_SOURCES =					\
>  STORAGE_HELPER_DISK_SOURCES =					\
>  		parthelper.c
>  
> +# Security framework and drivers for various models
> +SECLABEL_DRIVER_SOURCES =					\
> +		seclabel.h seclabel.c
> +
> +SECLABEL_DRIVER_SELINUX_SOURCES =				\
> +		seclabel_selinux.h seclabel_selinux.c
>  
>  NODE_DEVICE_DRIVER_SOURCES =					\
>  		node_device.c node_device.h
> @@ -370,6 +376,19 @@ libvirt_driver_nodedev_la_LDFLAGS += -module -avoid-version
>  endif
>  endif
>  
> +libvirt_driver_seclabel_la_SOURCES = $(SECLABEL_DRIVER_SOURCES)
> +if WITH_DRIVER_MODULES
> +mod_LTLIBRARIES += libvirt_driver_seclabel.la
> +else
> +noinst_LTLIBRARIES += libvirt_driver_seclabel.la
> +endif
> +if WITH_DRIVER_MODULES
> +libvirt_driver_seclabel_la_LDFLAGS = -module -avoid-version
> +endif
> +# XXX fixme
> +# if WITH_SELINUX
> +libvirt_driver_seclabel_la_SOURCES += $(SECLABEL_DRIVER_SELINUX_SOURCES)
> +# endif
>  
>  # Add all conditional sources just in case...
>  EXTRA_DIST +=							\
> @@ -388,8 +407,9 @@ EXTRA_DIST +=							\
>  		$(STORAGE_DRIVER_DISK_SOURCES)			\
>  		$(NODE_DEVICE_DRIVER_SOURCES)			\
>  		$(NODE_DEVICE_DRIVER_HAL_SOURCES)		\
> -		$(NODE_DEVICE_DRIVER_DEVKIT_SOURCES)
> -
> +		$(NODE_DEVICE_DRIVER_DEVKIT_SOURCES)		\
> +		$(SECLABEL_DRIVER_SOURCES)			\
> +		$(SECLABEL_DRIVER_SELINUX_SOURCES)
>  
>  # Empty source list - it merely links a bunch of convenience libs together
>  libvirt_la_SOURCES =

> diff --git a/src/domain_conf.c b/src/domain_conf.c
> index 32ed59f..5a0d4de 100644
> --- a/src/domain_conf.c
> +++ b/src/domain_conf.c
> @@ -359,6 +359,16 @@ void virDomainDeviceDefFree(virDomainDeviceDefPtr def)
>      VIR_FREE(def);
>  }
>  
> +void virDomainSecLabelDefFree(virDomainDefPtr def);
> +
> +void virDomainSecLabelDefFree(virDomainDefPtr def)
> +{
> +    if (def->seclabel.model)
> +        VIR_FREE(def->seclabel.model);
> +    if (def->seclabel.label)
> +        VIR_FREE(def->seclabel.label);
> +}
> +
>  void virDomainDefFree(virDomainDefPtr def)
>  {
>      unsigned int i;
> @@ -417,6 +427,8 @@ void virDomainDefFree(virDomainDefPtr def)
>      VIR_FREE(def->cpumask);
>      VIR_FREE(def->emulator);
>  
> +    virDomainSecLabelDefFree(def);
> +
>      VIR_FREE(def);
>  }
>  
> @@ -1644,6 +1656,56 @@ static int virDomainLifecycleParseXML(virConnectPtr conn,
>      return 0;
>  }
>  
> +static int
> +virDomainSecLabelDefParseXMLString(virConnectPtr conn,
> +                                   const char *str,
> +                                   int maxlen,
> +                                   const char *name,
> +                                   char **to,
> +                                   xmlXPathContextPtr ctxt)
> +{
> +    char *tmp = virXPathString(conn, str, ctxt);
> +
> +    if (tmp != NULL) {
> +        if (strlen(tmp) >= maxlen) {
> +            virDomainReportError(conn, VIR_ERR_INTERNAL_ERROR,
> +                                 _("\'%s\' longer than %d characters"),
> +                                 name, maxlen);
> +            return -1;
> +        }
> +        *to = tmp;
> +    } else {
> +        virDomainReportError(conn, VIR_ERR_INTERNAL_ERROR,
> +                             _("\'%s\' missing"), name);
> +        return -1;
> +    }
> +    return 0;
> +}

I'd suggest moving this call into xml.c, as a generic limited
length string extract function:

    virXPathStringLimit(conn, str, maxlen, ctxt)


> diff --git a/src/libvirt_sym.version.in b/src/libvirt_sym.version.in
> index de0bc4a..f533c17 100644
> --- a/src/libvirt_sym.version.in
> +++ b/src/libvirt_sym.version.in
> @@ -617,6 +617,9 @@ LIBVIRT_PRIVATE_@VERSION@ {
>  	virXPathString;
>  	virXMLPropString;
>  
> +	/* WIP */
> +	virDomainGetSecLabel;
> +	virDomainGetSecModel;

Ok, must remember to move these  into the public API section for
actual merge, rather than the per-version private section.

> @@ -2453,7 +2522,111 @@ cleanup:
>      return ret;
>  }
>  
> +static int qemudDomainGetSecLabel(virDomainPtr dom, virDomainSecLabelPtr seclabel)
> +{
> +    struct qemud_driver *driver = (struct qemud_driver *)dom->conn->privateData;
> +    virDomainObjPtr vm;
> +    const char *type;
> +    int ret = -1;
> +
> +    qemuDriverLock(driver);
> +    vm = virDomainFindByUUID(&driver->domains, dom->uuid);
> +    qemuDriverUnlock(driver);
> +
> +    if (!vm) {
> +        char uuidstr[VIR_UUID_STRING_BUFLEN];
> +
> +        virUUIDFormat(dom->uuid, uuidstr);
> +        qemudReportError(dom->conn, dom, NULL, VIR_ERR_INVALID_DOMAIN,
> +                         _("no domain with matching uuid '%s'"), uuidstr);
> +        goto cleanup;
> +    }
> +
> +    if (!(type = virDomainVirtTypeToString(vm->def->virtType))) {
> +        qemudReportError(dom->conn, dom, NULL, VIR_ERR_INTERNAL_ERROR,
> +                         _("unknown virt type in domain definition '%d'"),
> +                         vm->def->virtType);
> +        goto cleanup;
> +    }
> +
> +    /*
> +     * Theoretically, the pid can be replaced during this operation and
> +     * return the label of a different process.  If atomicity is needed,
> +     * further validation will be required.
> +     */

Well the PID as stored in the virDomainObjPtr can't be changed because
you've got a locked object. 

The OS level PID could have exited, though and in extreme circumstances have
cycled through all PIDs back to ours. We could sanity check that our PID
still exists after reading the label, by checking that our FD connecting to
the QEMU monitor hasn't seen SIGHUP/ERR on poll().

> +    if (virDomainIsActive(vm)) {
> +        if (driver->secLabelDriver && driver->secLabelDriver->domainGetLabel) {
> +            if (driver->secLabelDriver->domainGetLabel(dom->conn, vm, seclabel) == -1) {
> +                qemudReportError(dom->conn, dom, NULL, VIR_ERR_INTERNAL_ERROR,
> +                                 _("Failed to get security label"));
> +                goto cleanup;
> +            }
> +        }
> +    }
> +
> +    ret = 0;
> +
> +cleanup:
> +    if (vm)
> +        virDomainObjUnlock(vm);
> +    return ret;
> +}


In summary, this patch all looks pretty good to me from a the point of
view of libvirt integration & XML config representation

Daniel
-- 
|: Red Hat, Engineering, London   -o-   http://people.redhat.com/berrange/ :|
|: http://libvirt.org  -o-  http://virt-manager.org  -o-  http://ovirt.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: GnuPG: 7D3B9505  -o-  F3C9 553F A1DA 4AC2 5648 23C1 B3DF F742 7D3B 9505 :|

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
