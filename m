Message-ID: <SNT139-w65E511393D442CFCC6F92EABDC0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_93db0b2d-4955-4f41-a0ac-a3ca3b6ca89d_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley
	<sds@tycho.nsa.gov>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>, <refpolicy@oss1.tresys.com>
Subject: RE: Separate type for AF_UNIX socket created by syslogd_t
Date: Sat, 26 Feb 2011 03:29:22 +0000
In-Reply-To: <4D667EBA.3060205@tresys.com>
References: <SNT139-w42F5BDB103916DC8160624ABDA0@phx.gbl>
 <1298554512.31953.38.camel@moss-pluto>,<4D667EBA.3060205@tresys.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_93db0b2d-4955-4f41-a0ac-a3ca3b6ca89d_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Many thanks Stephen and Chris for all your replies!

In the first stage I will try to preserve the existing behaviors for socket by taking all kinds of socket classes in to account in security/mls_compute_sid() and re-send patches for SELinux kernel drivers. Yep so far these two functions could only take care of the special needs for the process class.

Best regards,
Harry

> Date: Thu, 24 Feb 2011 10:52:26 -0500
> From: cpebenito@tresys.com
> To: sds@tycho.nsa.gov
> CC: harrytaurus2002@hotmail.com; paul.moore@hp.com; selinux@tycho.nsa.gov; refpolicy@oss1.tresys.com
> Subject: Re: Separate type for AF_UNIX socket created by syslogd_t
> 
> On 02/24/11 08:35, Stephen Smalley wrote:
> > On Thu, 2011-02-24 at 10:44 +0000, HarryCiao wrote:
> >> Since syslogd_t runs at mls_systemhigh, both the /dev/log file and the
> >> unix_dgram_socket object bond to it are of mls_systemhigh, rendering
> >> that other application domain such as klogd_t running at lower
> >> security level failed to "sendto" it. One possible solution is to add
> >> syslogd_t to mlstrustedobject attribute since the unix_dgram_socket
> >> object inherits the creator's SID by default.
> >>
> >> However, the side effect is that syslogd_t is also the label for the
> >> entire syslogd's procfs entries. The attached two patches are aimed to
> >> resolve this problem while eliminating such side effect, by declaring
> >> a separate type, syslogd_s_t,  for the unix_dgram_socket object
> >> created by syslogd_t which alone could be added to the
> >> mlstrustedobject attribute.
> >>
> >> Thanks to Stephen's suggestion security_transition_sid() would be
> >> called in socket_sockcreate_sid() to query the relevant
> >> type_transition rule say in logging.pp for any newly created socket.
> >>
> >> After applying th! ese two patches below errors don't exist any more:
> >>
> >> type=1400 audit(1298535101.654:868): avc:  denied  { sendto } for
> >> pid=385 comm="klogd" path="/dev/log"
> >> scontext=system_u:object_r:klogd_t:s0
> >> tcontext=system_u:object_r:syslogd_t:s15:c0.c1023
> >> tclass=unix_dgram_socket
> >>
> >> BTW, do we have a way to actually display the label for the
> >> unix_dgram_socket that bond to /dev/log?
> >>
> [cut]
> > Unfortunately my original "simple" suggestion turns out to have side
> > effects. At present, the socket gets the same exact security context as
> > the creating process by default, including the role and MLS range, since
> > we just assign the SID directly.  But when using security_transition_sid
> > -> security_compute_sid, the new security context uses object_r as the
> > role for all objects and mls_compute_sid degrades the full MLS range to
> > the low level for objects. This is based on the desired behavior for
> > files and didn't take into account sockets.  Thus with your patch,
> > sockets will no longer be labeled identically to their creating process,
> > which will affect labeled networking and the network access controls.
> > 
> > To preserve existing behavior when there are no type transition rules
> > configured for sockets, I think security_compute_sid and mls_compute_sid
> > need logic handling the socket classes differently than other objects
> > (files).  And given that we are using dynamic class mappings now, those
> > socket class values would have to be looked up just like the process
> > class upon policy load.  Maybe we can come up with some generalized
> > solution that will be more flexible going forward for configuring how
> > different parts of the context are assigned for different classes.  We
> > have talked previously about using the role field even for files rather
> > than just making them all object_r.
> 
> It certainly would be nice to have all objects get the role of their
> creator so we can bring role-based policy separations back using RBAC
> features and not rely on 1:1 user:role mapping + UBAC.
> 
> 
> -- 
> Chris PeBenito
> Tresys Technology, LLC
> www.tresys.com | oss.tresys.com
 		 	   		  
--_93db0b2d-4955-4f41-a0ac-a3ca3b6ca89d_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Î¢ÈíÑÅºÚ
}
--></style>
</head>
<body class='hmmessage'>
Many thanks Stephen and Chris for all your replies!<br><br>In the first stage I will try to preserve the existing behaviors for socket by taking all kinds of socket classes in to account in security/mls_compute_sid() and re-send patches for SELinux kernel drivers. Yep so far these two functions could only take care of the special needs for the process class.<br><br>Best regards,<br>Harry<br><br>&gt; Date: Thu, 24 Feb 2011 10:52:26 -0500<br>&gt; From: cpebenito@tresys.com<br>&gt; To: sds@tycho.nsa.gov<br>&gt; CC: harrytaurus2002@hotmail.com; paul.moore@hp.com; selinux@tycho.nsa.gov; refpolicy@oss1.tresys.com<br>&gt; Subject: Re: Separate type for AF_UNIX socket created by syslogd_t<br>&gt; <br>&gt; On 02/24/11 08:35, Stephen Smalley wrote:<br>&gt; &gt; On Thu, 2011-02-24 at 10:44 +0000, HarryCiao wrote:<br>&gt; &gt;&gt; Since syslogd_t runs at mls_systemhigh, both the /dev/log file and the<br>&gt; &gt;&gt; unix_dgram_socket object bond to it are of mls_systemhigh, rendering<b!
 r>&gt; &gt;&gt; that other application domain such as klogd_t running at lower<br>&gt; &gt;&gt; security level failed to "sendto" it. One possible solution is to add<br>&gt; &gt;&gt; syslogd_t to mlstrustedobject attribute since the unix_dgram_socket<br>&gt; &gt;&gt; object inherits the creator's SID by default.<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; However, the side effect is that syslogd_t is also the label for the<br>&gt; &gt;&gt; entire syslogd's procfs entries. The attached two patches are aimed to<br>&gt; &gt;&gt; resolve this problem while eliminating such side effect, by declaring<br>&gt; &gt;&gt; a separate type, syslogd_s_t,  for the unix_dgram_socket object<br>&gt; &gt;&gt; created by syslogd_t which alone could be added to the<br>&gt; &gt;&gt; mlstrustedobject attribute.<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; Thanks to Stephen's suggestion security_transition_sid() would be<br>&gt; &gt;&gt; called in socket_sockcreate_sid() to query the relevant<br>&gt; &gt;&gt; type_tra!
 nsition rule say in logging.pp for any newly created socket.<br>&gt; &
gt;&gt;<br>&gt; &gt;&gt; After applying th! ese two patches below errors don't exist any more:<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; type=1400 audit(1298535101.654:868): avc:  denied  { sendto } for<br>&gt; &gt;&gt; pid=385 comm="klogd" path="/dev/log"<br>&gt; &gt;&gt; scontext=system_u:object_r:klogd_t:s0<br>&gt; &gt;&gt; tcontext=system_u:object_r:syslogd_t:s15:c0.c1023<br>&gt; &gt;&gt; tclass=unix_dgram_socket<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; BTW, do we have a way to actually display the label for the<br>&gt; &gt;&gt; unix_dgram_socket that bond to /dev/log?<br>&gt; &gt;&gt;<br>&gt; [cut]<br>&gt; &gt; Unfortunately my original "simple" suggestion turns out to have side<br>&gt; &gt; effects. At present, the socket gets the same exact security context as<br>&gt; &gt; the creating process by default, including the role and MLS range, since<br>&gt; &gt; we just assign the SID directly.  But when using security_transition_sid<br>&gt; &gt; -&gt; security_compute_sid, the new secur!
 ity context uses object_r as the<br>&gt; &gt; role for all objects and mls_compute_sid degrades the full MLS range to<br>&gt; &gt; the low level for objects. This is based on the desired behavior for<br>&gt; &gt; files and didn't take into account sockets.  Thus with your patch,<br>&gt; &gt; sockets will no longer be labeled identically to their creating process,<br>&gt; &gt; which will affect labeled networking and the network access controls.<br>&gt; &gt; <br>&gt; &gt; To preserve existing behavior when there are no type transition rules<br>&gt; &gt; configured for sockets, I think security_compute_sid and mls_compute_sid<br>&gt; &gt; need logic handling the socket classes differently than other objects<br>&gt; &gt; (files).  And given that we are using dynamic class mappings now, those<br>&gt; &gt; socket class values would have to be looked up just like the process<br>&gt; &gt; class upon policy load.  Maybe we can come up with some generalized<br>&gt; &gt; solution tha!
 t will be more flexible going forward for configuring how<br>&gt; &gt;
 different parts of the context are assigned for different classes.  We<br>&gt; &gt; have talked previously about using the role field even for files rather<br>&gt; &gt; than just making them all object_r.<br>&gt; <br>&gt; It certainly would be nice to have all objects get the role of their<br>&gt; creator so we can bring role-based policy separations back using RBAC<br>&gt; features and not rely on 1:1 user:role mapping + UBAC.<br>&gt; <br>&gt; <br>&gt; -- <br>&gt; Chris PeBenito<br>&gt; Tresys Technology, LLC<br>&gt; www.tresys.com | oss.tresys.com<br> 		 	   		  </body>
</html>
--_93db0b2d-4955-4f41-a0ac-a3ca3b6ca89d_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
