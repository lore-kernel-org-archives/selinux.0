Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l42Jo2vc016327
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 15:50:02 -0400
Received: from ik-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l42Jo138016154
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 19:50:01 GMT
Received: by ik-out-1112.google.com with SMTP id b32so230440ika
        for <selinux@tycho.nsa.gov>; Wed, 02 May 2007 12:50:00 -0700 (PDT)
Message-ID: <f888952b0705021249o40ef05cn1ac2524d9582e3c9@mail.gmail.com>
Date: Wed, 2 May 2007 15:49:58 -0400
From: "Dave Quigley" <dquigley+selinux@gmail.com>
To: selinux@tycho.nsa.gov
Subject: rename_dir_perms missing
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,
    I was looking through the reference policy and I noticed that
there is a problem with rename_dirs_pattern. It uses a define called
rename_dir_perms that does not exist anywhere. The interface is $1 is
the type that wants permissions $2 is the container type and $3 is the
directory type. rename_dir_perms is used on the $3 target and is
missing completely. The reason this didn't show up is that
rename_dirs_pattern is never actually used anywhere. Which permissions
are needed for this to work?

Dave Quigley

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
