Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA20771
	for <selinux@tycho.nsa.gov>; Fri, 14 Feb 2003 11:02:31 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1EG2TI15759
	for <selinux@tycho.nsa.gov>; Fri, 14 Feb 2003 16:02:29 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h1EG2Tf15755 for <selinux@tycho.nsa.gov>; Fri, 14 Feb 2003 16:02:29 GMT
Message-Id: <200302141609.LAA10146@moss-shockers.ncsc.mil>
Date: Fri, 14 Feb 2003 11:09:59 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Transitivity in role dominance relation
To: selinux@tycho.nsa.gov, kimhc@kjist.ac.kr
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I've been testing role dominance relation. expecially,
> the transitivity of role dominance relation.
> 
> prof_r > (osg_r, dbg_r) > stud_r
> 
> as;
> 
> dominance { role prof_r { role osg_r; role dbg_r; } }
> dominance { role osg_r { role stud_r; } }
> dominance { role dbg_r { role stud_r; } }
> # disabled direct relation
> #dominance { role prof_r { role stud_r; } }
> 
> In the above relation, I guessed that the prof_r role can not inherit
> the types of stud_r as seeing below;

Yes, this is an artifact of the implementation in the policy compiler,
and doesn't seem desirable.  If you were to specify the above as a single
dominance statement, e.g.
dominance { role prof_r { role osg_r { role stud_r; } role dbg_r { role stud_r; 
} } }
, then prof_r would inherit the types of stud_r and every user
authorized for prof_r would also be authorized for stud_r.  Of greater
concern is the fact that the order of the dominance statements affects
the end result; notice what happens if you simply move the dominance
statements for osg_r and dbg_r before the statement for prof_r.  The
compiler should be changed to eliminate this ordering dependency.

As an aside, note that the example policy does not use role dominance,
and some have suggested that it should be eliminated entirely.  Keep in
mind that the RBAC model does not provide any additional security
mechanism; it is merely an abstraction layer to conveniently group
domains into sets for assignment to users.  The real security of the
system is based on the TE model.

> And I also could not get the context of stud_r using the newrole command
> after getting the context of osg_r or dbg_r.

You need to allow the corresponding role transitions and domain transitions
in the policy.  role dominance doesn't implicitly grant such accesses.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
