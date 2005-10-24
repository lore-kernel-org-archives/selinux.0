Message-ID: <435D1A0A.7040004@cornell.edu>
Date: Mon, 24 Oct 2005 13:29:46 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE 2 ] Fix dbase transactions
References: <435AC7F5.7030602@cornell.edu> <1130173742.17609.97.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1130173742.17609.97.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
> All 8 patches merged as of libsepol 1.9.26 and libsemanage 1.3.32.
>   

Okay... next TODO:

- must fill in the blanks (user query, boolean query, boolean exists).
- implement count function (easy)
- pass the handle where appropriate
- convert records to use status code on failure



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
