Subject: Re: racoon got dead due to permission lacking
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kohei KaiGai <kaigai@ak.jp.nec.com>
Cc: dwalsh@redhat.com, cpebenito@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <1201288630.21288.277.camel@moss-spartans.epoch.ncsc.mil>
References: <47997296.2010603@ak.jp.nec.com>
	 <1201288630.21288.277.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 28 Jan 2008 07:32:30 -0500
Message-Id: <1201523550.27244.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-01-25 at 14:17 -0500, Stephen Smalley wrote:
> On Fri, 2008-01-25 at 14:24 +0900, Kohei KaiGai wrote:
> > When I tested labeled ipsec, racoon got dead with the following messages:
> > (I added some line break for reader's confortable)
> > 
> > | type=AVC msg=audit(1201052881.758:783): avc:  denied  { read }
> > |   for  pid=26854 comm="racoon" name="net" dev=proc ino=4026531867
> > |   scontext=root:system_r:racoon_t:s0
> > |   tcontext=system_u:object_r:proc_t:s0 tclass=dir
> 
> That one is a kernel bug (in 2.6.24).  Should have a fix soon - patch is
> being reviewed.

Fix upstreamed,
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=b1aa5301b9f88a4891061650c591fb8fe1c1


> > | type=AVC msg=audit(1201052881.758:784): avc:  denied  { read }
> > |   for  pid=26854 comm="racoon" name="unix" dev=proc ino=4026532018
> > |   scontext=root:system_r:racoon_t:s0
> > |   tcontext=system_u:object_r:proc_t:s0 tclass=file
> > | type=AVC msg=audit(1201052881.758:785): avc:  denied  { node_bind }
> > |   for  pid=26854 comm="racoon" saddr=127.0.0.1 src=500
> > |   scontext=root:system_r:racoon_t:s0
> > |   tcontext=system_u:object_r:lo_node_t:s0 tclass=udp_socket
> > | type=AVC msg=audit(1201052881.759:786): avc:  denied  { node_bind }
> > |   for  pid=26854 comm="racoon" saddr=10.19.71.81 src=500
> > |   scontext=root:system_r:racoon_t:s0
> > |   tcontext=system_u:object_r:node_t:s0 tclass=udp_socket
> > | type=AVC msg=audit(1201052881.759:787): avc:  denied  { node_bind }
> > |   for  pid=26854 comm="racoon" saddr=0000:0000:0000:0000:0000:0000:0000:0001 src=500
> > |   scontext=root:system_r:racoon_t:s0
> > |   tcontext=system_u:object_r:compat_ipv4_node_t:s0 tclass=udp_socket
> > | type=AVC msg=audit(1201052881.759:788): avc:  denied  { node_bind }
> > |   for  pid=26854 comm="racoon" saddr=fe80:0000:0000:0000:0211:09ff:fe34:68e0 src=500
> > |   scontext=root:system_r:racoon_t:s0
> > |   tcontext=system_u:object_r:link_local_node_t:s0 tclass=udp_socket
> > 
> > selinux-policy-3.2.5-15.fc9 and ipsec-tools-0.7-8.fc9 are installed.
> > It seems to me that racoon tries to read /proc/net/unix, and bind adresses
> > on udp socket.
> > 
> > The attached patch grant those permissions, and it killed this matter.
> > Please apply it.
> > 
> > Thanks,
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
