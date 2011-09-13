Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8D51Erg004380
	for <selinux@tycho.nsa.gov>; Tue, 13 Sep 2011 01:01:14 -0400
Received: from cp-out9.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8D51BZs007498
	for <selinux@tycho.nsa.gov>; Tue, 13 Sep 2011 05:01:12 GMT
Subject: [RFC] semanage.conf manual page (was Re: policycoreutils manpages
 needed)
From: Guido Trentalancia <guido@trentalancia.com>
To: Eric Paris <eparis@parisplace.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, russell@coker.com.au,
        SE-Linux
	 <selinux@tycho.nsa.gov>
Date: Tue, 13 Sep 2011 07:00:45 +0200
In-Reply-To: <1315862884.2223.33.camel@vortex>
References: <201109011509.05872.russell@coker.com.au>
	 <4E5F8BAA.6060208@redhat.com> <1314912106.2334.2.camel@vortex>
	 <CACLa4ptfSU3obZ8OyMVFfKDsqwLQn58-O9YRUbCyU8=mLzn=tA@mail.gmail.com>
	 <1315862884.2223.33.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315890045.2177.47.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So, here is a first new manual page that I propose to introduce:
semanage.conf(5).

On Mon, 2011-09-12 at 23:28 +0200, Guido Trentalancia wrote:
> On Thu, 2011-09-01 at 21:52 -0400, Eric Paris wrote:
> > On Thu, Sep 1, 2011 at 5:21 PM, Guido Trentalancia
> > <guido@trentalancia.com> wrote:
> > > On Thu, 2011-09-01 at 09:42 -0400, Daniel J Walsh wrote:
> > >> On 09/01/2011 01:09 AM, Russell Coker wrote:
> > >> > Has anyone written manpages for genhomedircon, sepolgen-ifgen, and
> > >> > seunshare? If not is there someone with some spare time and man
> > >> > page writing skill?

[cut]

> I would like to take this opportunity to suggest that we create manual
> pages for configuration files where possible (none available at the
> moment ?!?).
> 
> For example, the very first one I would like to have is
> semanage.conf.5. 

diff -pruN selinux/policycoreutils/semanage/semanage.conf.5 selinux-13092011-new-manual-pages/policycoreutils/semanage/semanage.conf.5
--- selinux/policycoreutils/semanage/semanage.conf.5	1970-01-01 01:00:00.000000000 +0100
+++ selinux-13092011-new-manual-pages/policycoreutils/semanage/semanage.conf.5	2011-09-13 06:54:47.309754193 +0200
@@ -0,0 +1,93 @@
+.TH semanage.conf "5" "September 2011" "semanage.conf" "Linux System Administration"
+.SH NAME
+semanage.conf \- global configuration file for the SELinux Management library
+.SH DESCRIPTION
+.PP
+The
+.BR semanage.conf
+file is usually located under the directory /etc/selinux and it is used for run-time configuration of the
+behavior of the SELinux Management library.
+
+.PP
+Each line should contain a configuration parameter followed by the equal sign ("=") and then followed by the configuration value for that
+parameter. Anything after the "#" symbol is ignored similarly to empty lines.
+
+.PP
+The following parameters are allowed:
+
+.RS
+.TP
+.B module-store 
+Specify how the SELinux Management library should interact with the SELinux policy store. When set to "direct", the SELinux
+Management library writes to the SELinux policy module store directly (this is the default setting).
+Otherwise a socket path or a server name can be used for the argument.
+If the argument begins with "/" (as in "/foo/bar"), it represents the path to a named socket that should be used to connect the policy management
+server.
+If the argument does not begin with a "/" (as in "foo.com:4242"), it should be interpreted as the name of a remote policy management server
+to be used through a TCP connection (default port is 4242 unless a different one is specified after the server name using the colon to separate
+the two fields).
+
+.TP
+.B policy-version 
+When generating the policy, by default
+.BR semanage
+will set the policy version to POLICYDB_VERSION_MAX, as defined in <sepol/policydb/policydb.h>. Change this setting if a different
+version needs to be set for the policy.
+
+.TP
+.B expand-check
+Whether or not to check "neverallow" rules when executing all
+.BR semanage
+command. It can be set to either "0" (disabled) or "1" (enabled) and by default it is enabled. There might be a large
+penalty in execution time if this option is enabled.
+
+.TP
+.B file-mode
+By default the permission mode for the run-time policy files is set to 0644.
+
+.TP
+.B save-previous
+It controls whether the previous module directory is saved after a successful commit to the policy store and it can be set to
+either "true" or "false". By default it is set to "false" (the previous version is deleted).
+
+.TP
+.B save-linked
+It controls whether the previously linked module is saved (with name "base.linked") after a successful commit to the policy store.
+It can be set to either "true" or "false" and by default it is set to "false" (the previous module is deleted).
+
+.TP
+.B usepasswd 
+Whether or not to enable the use getpwent() to obtain a list of home directories to label. It can be set to either "true" or "false".
+By default it is set to "true".
+
+.TP
+.B disable-genhomedircon
+It controls whether or not the genhomedircon function is executed when using the
+.BR semanage
+command and it can be set to either "false" or "true". By default the genhomedircon functionality is enabled (equivalent
+to this option set to "false").
+
+.TP
+.B handle-unknown
+This option controls the kernel behavior for handling permissions defined in the kernel but missing from the actual policy.
+It can be set to "deny", "reject" or "allow".
+
+.TP
+.B bzip-blocksize
+It should be in the range 0-9. A value of 0 means no compression. By default the bzip block size is set to 9 (actual block
+size value is obtained after multiplication by 100000).
+
+.TP
+.B bzip-small
+When set to "true", the bzip algorithm shall try to reduce its system memory usage. It can be set to either "true" or "false" and
+by default it is set to "false".
+
+.SH "SEE ALSO"
+.TP
+semanage(8)
+.PP
+
+.SH AUTHOR
+This manual page was written by Guido Trentalancia <guido@trentalancia.com>.
+
+The SELinux management library was written by Tresys Technology LLC and Red Hat Inc.

Very simple, but possibly useful...

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
