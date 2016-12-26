Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBQAXdnv010010
 for <selinux@tycho.nsa.gov>; Mon, 26 Dec 2016 05:33:39 -0500
From: Russell Coker <russell@coker.com.au>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Reply-To: russell@coker.com.au
Cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: Another getcon() vs getcon_raw() issue in systemd
Date: Mon, 26 Dec 2016 21:33:21 +1100
Message-ID: <7415401.n4TOyH4plo@russell.coker.com.au>
In-Reply-To: <CAJfZ7==GE=E0LfnbtwLM1PRPKaiF9SCje+RSi3J8FG41HaP56g@mail.gmail.com>
References: <4028608.pKKk40ccRB@russell.coker.com.au>
 <CAJfZ7==GE=E0LfnbtwLM1PRPKaiF9SCje+RSi3J8FG41HaP56g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Saturday, 17 December 2016 12:15:45 AM AEDT Nicolas Iooss wrote:
> On Fri, Dec 16, 2016 at 1:33 PM, Russell Coker <russell@coker.com.au> wrote:
> > http://selinux.tycho.nsa.narkive.com/cZUV3wmW/selinux-set-callback-problem
> > 
> > The above URL has the archive of the last time I raised an issue like
> > this.
> > Thanks to Nicolas Iooss for pointing out the solution.
> > 
> > type=USER_AVC msg=audit(1481891298.695:687055): pid=1 uid=0
> > auid=4294967295
> > ses=4294967295 subj=system_u:system_r:init_t:s0 msg='avc:  denied  {
> > status }
> > for auid=n/a uid=0 gid=0 cmdline="/lib/systemd/systemd-machined"
> > scontext=system_u:system_r:systemd_machined_t:SystemLow
> > tcontext=system_u:system_r:init_t:s0 tclass=system
> > exe="/lib/systemd/systemd"
> > sauid=0 hostname=? addr=? terminal=?'
> > 
> > Now in Debian/Unstable we have a similar issue with systemd 232-7 giving
> > audit.log entries like the above.
> 
> Hi,
> I quickly searched in systemd git tree where the source context comes from.
> My starting point was the call to sd_bus_query_sender_creds()
> in mac_selinux_generic_access_check() [1]. This function may call
> sd_bus_get_name_creds() [2] -> bus_get_name_creds_dbus1() [3]
> -> sd_bus_call_method("org.freedesktop.DBus",
> ..., "GetConnectionSELinuxSecurityContext", ..., "s", unique ? unique :
> name) [4]. As the audit entry you sent comes from a DBus call
> between systemd-machined and systemd, this code path is likely to have been
> the origin of the source context.
> 
> The DBus method which is called is implemented in DBus function
> bus_driver_handle_get_connection_selinux_security_context() [5], which
> calls several functions until libselinux's getpeercon() [6]. As it is not
> getpeercon_raw(), this may give the translated label. In order to test
> this, could you please execute the following command and tell its output?
> 
> dbus-send --system --print-reply --dest=org.freedesktop.DBus
> /org/freedesktop/DBus
> org.freedesktop.DBus.GetConnectionSELinuxSecurityContext
> 'string:org.freedesktop.machine1'

Below is the output, looks like your analysis is correct.

method return time=1482748196.242707 sender=org.freedesktop.DBus -> 
destination=:1.1301 serial=3 reply_serial=2
   array of bytes "system_u:system_r:systemd_machined_t:SystemLow"

> DBus specification is quite strange about the method: "Returns the security
> context used by SELinux, in an unspecified format. If you know what this
> means, please contribute documentation via the D-Bus bug tracking system."

Strange, something for someone here to look into I guess.

> [7]. It seems GetConnectionCredentials should be preferred. In order to see
> whether modifying systemd code would be enough to fix this, or whether it
> is a bug in the D-Bus interfaces, what does this command return on your
> system?
> 
> dbus-send --system --print-reply --dest=org.freedesktop.DBus
> /org/freedesktop/DBus org.freedesktop.DBus.GetConnectionCredentials
> 'string:org.freedesktop.machine1'

Here's the result, does it indicate that D-Bus or systemd should be changed?

method return time=1482748196.247091 sender=org.freedesktop.DBus -> 
destination=:1.1302 serial=3 reply_serial=2
   array [
      dict entry(
         string "ProcessID"
         variant             uint32 1123
      )
      dict entry(
         string "UnixUserID"
         variant             uint32 0
      )
      dict entry(
         string "LinuxSecurityLabel"
         variant             array of bytes 
"system_u:system_r:systemd_machined_t:s0" + \0
      )
   ]

Thanks for your help.  I hope to get this fixed before the next release of 
Debian is frozen...

> [1]
> https://github.com/systemd/systemd/blob/v232/src/core/selinux-access.c#L206
> [2]
> https://github.com/systemd/systemd/blob/v232/src/libsystemd/sd-bus/bus-conve
> nience.c#L542 [3]
> https://github.com/systemd/systemd/blob/v232/src/libsystemd/sd-bus/bus-contr
> ol.c#L929 [4]
> https://github.com/systemd/systemd/blob/v232/src/libsystemd/sd-bus/bus-contr
> ol.c#L865 [5]
> https://cgit.freedesktop.org/dbus/dbus/tree/bus/driver.c?h=dbus-1.10#n1809
> [6]
> https://cgit.freedesktop.org/dbus/dbus/tree/bus/selinux.c?h=dbus-1.10#n724
> [7]
> https://cgit.freedesktop.org/dbus/dbus/tree/doc/dbus-specification.xml?h=dbu
> s-1.10#n6200


-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
