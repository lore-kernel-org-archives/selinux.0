Subject: Re: VirtualGL and selinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mark Dalton <mdalton@princeton.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4F69D204.9070609@princeton.edu>
References: <4F69D204.9070609@princeton.edu>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 21 Mar 2012 14:39:57 -0400
Message-ID: <1332355197.27512.103.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-03-21 at 09:05 -0400, Mark Dalton wrote:
> 
> Thank you for selinux.   I have been trying to run it on our machines
> especially any public facing and servers.  We use audit2allow and
> generate mods.
> 
> I did not find a 'dumb users forum'.   Could you point me to a place
> to find this or suggest how to fix this?   I worked with our local
> expert
> on selinux.   (I can repeat this if that helps).

Not a 'dumb users forum', but there are some more user-centric resources
like the fedora selinux list, the Fedora SELinux User Guide, etc.  But
it is fine to post such questions here as well.

> I was not able to get VirtualGL and selinux to work together.
> It is something during boot time it seems.  I have tried generating
> rules based on audit/audit.log.

If you are still getting avc messages during boot, then post those
messages. If you are not getting any avc messages during boot, then run
semodule -DB to remove the dontaudit rules and try again (and then run
semodule -B afterward), and post those avc messages.  Don't apply
audit2allow to the avc messages generated while dontaudit rules were
removed.

> The VirtualGL web http://www.virtualgl.org/Documentation/RHEL6
> states they don't know how to make it work either.
> 
> I have tried in permissive mode after boot and that did not work
> either,
> which is why I think it is something during boot time.  Like the
> device
> setup. My guess is related to: /dev/dri as it sets up these and then
> access to the /dev/nvidia0 and /dev/nvidiactl are restricted to
> vglusers
> group (in my case it can be configured with/without group
> restriction).

If so, then you should have some avc denials pertaining to those device
nodes.  ls -Z /dev/dri /dev/nvidia* might be interesting.

> From VirtualGL website they also have:
> 
> vglgenkey Issues
> Currently, the only known way to make vglgenkey work (vglgenkey is
> used to grant 3D X Server access to members of the vglusers group) is
> to disable SELinux. With SELinux enabled, the /usr/bin/xauth file is
> hidden within the context of the GDM startup scripts, so vglgenkey has
> no way of generating or importing an xauth key
> to /etc/opt/VirtualGL/vgl_xauth_key (and, for that matter, access is
> denied to /etc/opt/VirtualGL as well.)

If so, then you should have some avc denials pertaining to running xauth
or reading .Xauthority or accessing /etc/opt/VirtualGL.  ls -Z
$HOME/.Xauthority might be interesting.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
