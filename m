Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA25302
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 17:30:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA01181
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 21:30:07 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA01172
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 21:30:06 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: vishwakarma singh <vsingh014@yahoo.com>
Subject: Re: role allow rules
Date: Fri, 21 Jun 2002 23:30:17 +0200
References: <20020621152020.45350.qmail@web14306.mail.yahoo.com>
In-Reply-To: <20020621152020.45350.qmail@web14306.mail.yahoo.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020621213017.D4F7156@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've CC'd this to the mailing list, as I'm not sure I can answer it properly.

On Fri, 21 Jun 2002 17:20, you wrote:
>   I like to know whenever a role changes , how the
> ROLE ALLOW RULES  mentioned in the rbac policy
> configuration file  are checked , whether the role
> change is allowed  or not .
>              I also want to know difference between a
> role transition rule and a role allow rule . If there
> are role transition rules , why there is need of role
> allow rules .

I believe that role allow rules permit transitions for programs such as 
login, newrole, and run_init, while transition rules cause automatic 
transitions and are deprecated in the current model.

I'm sure Stephen can clarify the issue.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
