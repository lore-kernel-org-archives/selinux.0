Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Howard Holm <hdholm@epoch.ncsc.mil>
Subject: Re: db conflict ?
Date: Fri, 12 Apr 2002 19:09:11 +0200
Cc: SELinux@tycho.nsa.gov
References: <Pine.GSO.4.33.0204121042260.21729-100000@raven> <20020412151252.D5E1D23B16@lyta.coker.com.au> <20020412130109.A15470@gricklegrass.epoch.ncsc.mil>
In-Reply-To: <20020412130109.A15470@gricklegrass.epoch.ncsc.mil>
MIME-Version: 1.0
Message-Id: <20020412170911.EAE91287FF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 12 Apr 2002 19:01, Howard Holm wrote:
> I think adding a magic number to the policy file is probably a good idea.
> I'm not quite as sure about the file name containing a version number, but
> it's probably a good idea as well.  My reading of the FHS (v2.2) is that
> it prohibits /selinux/.  My suggestion would be /etc/security/policy/ or
> /etc/security/policies/ with the thought that there might be at least
> multiple versions in the directory so plural might be appropriate.

/etc/security/policy sounds good to me.

Having multiple versions of the same policy does not require a plural (IMHO). 
The plural would be required if we had a choice of policies that differed in 
some way other than the version number.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
