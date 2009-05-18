Subject: Re: avc: denied null
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dominick Grift <domg472@gmail.com>
Cc: SELinux@tycho.nsa.gov, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1242641994.470.5.camel@notebook2.grift.internal>
References: <1242641994.470.5.camel@notebook2.grift.internal>
Content-Type: text/plain
Date: Mon, 18 May 2009 08:50:13 -0400
Message-Id: <1242651013.29973.197.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-05-18 at 12:19 +0200, Dominick Grift wrote:
> I have enabled XACE on my systems and sometimes i get weird avc denials:
> 
> avc:  denied  null for request=GLX:MakeCurrent comm=glxinfo
> resid=2600001 restype=<unknown>
> scontext=dgrift:dgrift_r:dgrift_t:s0-s0:c0.c1023
> tcontext=dgrift:dgrift_r:dgrift_t:s0-s0:c0.c1023 tclass=x_resource
> 
> avc:  denied  null for request=X11:GetInputFocus comm=/usr/bin/ggl-qt
> xdevice="Virtual core keyboard"
> scontext=dgrift:dgrift_r:dgrift_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
> 
> avc:  denied  null for request=X11:UnmapWindow comm=/usr/bin/ggl-qt
> xdevice="Virtual core keyboard"
> scontext=dgrift:dgrift_r:dgrift_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=x_device
> 
> I was wondering if this is a bug or of this is expected behaviour.
> 
> I do not notice any loss in functionality.

That would be a bug.  Details?  rpm -q -f /usr/bin/Xorg /etc/selinux

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
