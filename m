Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7KCZn7X014605
	for <selinux@tycho.nsa.gov>; Mon, 20 Aug 2007 08:35:49 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7KCZmgL013186
	for <selinux@tycho.nsa.gov>; Mon, 20 Aug 2007 12:35:48 GMT
Subject: MLS directory write constraints
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Cc: joe@nall.com
Content-Type: text/plain
Date: Mon, 20 Aug 2007 08:34:57 -0400
Message-Id: <1187613297.27524.10.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

After doing some work on some MLS systems last week, I observed some
constraint denials like this:

type=AVC msg=audit(1187122358.679:120): avc:  denied  { write } for
pid=2829 comm="foo" name="run" dev=dm-0 ino=3309608
scontext=system_u:system_r:foo_t:s15:c0.c1023
tcontext=system_u:object_r:var_run_t:s0-s15:c0.c1023
tclass=dir

Where a daemon has TE rules for creating it's PID file in /var/run, but
gets denied by this MLS constraint:

mlsconstrain { file ... dir ... } { write create setattr relabelfrom append unlink link rename mounton }
	(( l1 eq l2 ) or
	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
	 (( t2 == mlsfilewriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
	 ( t1 == mlsfilewrite ) or
	 ( t2 == mlstrustedobject ));

It seems like it should be able to create a file in the directory, since
the daemon's level is within the range of the directory.  The
constraints for the other dir-specific permissions seems to confirm
this:

mlsconstrain dir { add_name remove_name reparent rmdir }
	((( l1 dom l2 ) and ( l1 domby h2 )) or
	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
	 ( t1 == mlsfilewrite ) or
	 ( t2 == mlstrustedobject ));

But since creating or deleting a file in a directory requires write and
add_name or remove_name, respectively, you still must have equality in
level to create a file in /var/run.  Because of this, I believe there
potentially are superfluous write downs for daemons that don't run in
system low.  I think the constraints should be changed to this:

# single level "write"
mlsconstrain { file ... } { write create setattr relabelfrom append unlink link rename mounton }
	(( l1 eq l2 ) or
	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
	 (( t2 == mlsfilewriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
	 ( t1 == mlsfilewrite ) or
	 ( t2 == mlstrustedobject ));

mlsconstrain dir { create setattr relabelfrom append unlink link rename mounton reparent rmdir }
	(( l1 eq l2 ) or
	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
	 (( t2 == mlsfilewriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
	 ( t1 == mlsfilewrite ) or
	 ( t2 == mlstrustedobject ));

# ranged "write" for adding and removing directory entries
mlsconstrain dir { write add_name remove_name }
	((( l1 dom l2 ) and ( l1 domby h2 )) or
	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
	 ( t1 == mlsfilewrite ) or
	 ( t2 == mlstrustedobject ));

Comments?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
