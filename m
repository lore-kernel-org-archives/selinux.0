Date: Thu, 25 Mar 2010 09:45:35 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
To: Eric Paris <eparis@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux <selinux@tycho.nsa.gov>, paul.moore@hp.com
Subject: Re: svirt on MLS has strange AVC.
Message-ID: <20100325094535.GA9633@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <4BA7E4BF.1040002@redhat.com> <1269301672.2911.31.camel@localhost> <4BA8A771.8060502@redhat.com> <20100323114422.GC364@redhat.com> <1269484959.2925.9.camel@dhcp235-240.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1269484959.2925.9.camel@dhcp235-240.rdu.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Mar 24, 2010 at 10:42:39PM -0400, Eric Paris wrote:
> On Tue, 2010-03-23 at 11:44 +0000, Daniel P. Berrange wrote:
> > On Tue, Mar 23, 2010 at 07:35:13AM -0400, Daniel J Walsh wrote:
> > > On 03/22/2010 07:47 PM, Eric Paris wrote:
> > > The socket file is labeled svirt_var_run_t and has the correct level.
> > > 
> > > I believe the socket file was created by qemu.  Dan can you confirm this.
> > 
> > Yes, these sockets are created by QEMU when it starts. libvirt just gives
> > it the path at which to create the socket.
> > 
> > >  # ls -lZa /var/lib/libvirt/qemu/
> > > drwx------. qemu qemu system_u:object_r:svirt_var_run_t:s0-s15:c0.c1023 .
> > > drwxr-xr-x. root root system_u:object_r:virt_var_lib_t:s0 ..
> > > srwxr-xr-x. qemu qemu system_u:object_r:svirt_var_run_t:s0:c1 xguest.monitor
> 
> And then libvirt attaches to the other end?

Yes, the $GUEST.monitor sockets are the runtime control interface for QEMU,
which libvirt connects to to change live changes.


Daniel
-- 
|: Red Hat, Engineering, London    -o-   http://people.redhat.com/berrange/ :|
|: http://libvirt.org -o- http://virt-manager.org -o- http://deltacloud.org :|
|: http://autobuild.org        -o-         http://search.cpan.org/~danberr/ :|
|: GnuPG: 7D3B9505  -o-   F3C9 553F A1DA 4AC2 5648 23C1 B3DF F742 7D3B 9505 :|

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
