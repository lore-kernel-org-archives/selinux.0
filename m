MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Writing SELinux Policy...(Allow ALL, Deny Few)
Date: Wed, 28 May 2008 13:29:25 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D049EC66B@de01exm68.ds.mot.com>
In-Reply-To: <1211200563.7486.40.camel@moss-spartans.epoch.ncsc.mil>
References: <1210336991.6434.200.camel@moss-spartans.epoch.ncsc.mil> <Xine.LNX.4.64.0805121034110.22560@us.intercode.com.au> <1210595177.6206.21.camel@moss-spartans.epoch.ncsc.mil> <1211200563.7486.40.camel@moss-spartans.epoch.ncsc.mil>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

>From what I understand, given the SELinux framework...

EVERY THING by default is Denied, *except* what the policy explicitly
allows...

How can I configure things (if at all possible), such that  
EVERY THING by default is Allowed, *except* the specific things Denied
in the policy !!

Is this doable ?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
