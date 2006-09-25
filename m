Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PKdutc027532
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 16:39:56 -0400
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8PKcrAk021502
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 20:38:53 GMT
Subject: Re: Latest diffs.  Trimmed down this time.
From: Erich Schubert <erich@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45183220.8090106@redhat.com>
References: <45183220.8090106@redhat.com>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 22:39:48 +0200
Message-Id: <1159216788.12513.17.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Daniel,
> Doesn't ssh need
> +       userdom_search_all_users_home_dirs(sshd_t)

getattr is supposedly sufficient, no need for searching. See earlier
thread.

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
     You know we all became mathematicians for the same reason:     //\
                  we were lazy. --- Max Rosenlicht                  V_/_
           Es ist besser, geliebt und verloren zu haben,
                   als niemals geliebt zu haben.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
