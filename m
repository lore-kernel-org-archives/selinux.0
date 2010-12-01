MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: What can selinux do that "audit" by itself cant do ?
Date: Tue, 30 Nov 2010 19:17:30 -0500
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D09E9FCDD@de01exm68.ds.mot.com>
In-Reply-To: <1193840770.3983.86.camel@moss-spartans.epoch.ncsc.mil>
References: <Pine.LNX.4.44.0710262329300.30215-100000@citation2.av8.net> <1193840770.3983.86.camel@moss-spartans.epoch.ncsc.mil>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "Steve Grubb" <sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

Had a thought pop up in my head, and was just cusrious...

Lets say I am using SELinux in my Linux product to monitor the
filesystem and generate avc deny events in audit.log, whenever my strict
selinux policy is violated... And I am running in Permissive mode (so
NOT actively preventing anything, just reporting...).

Is there any reason why I cant simply write a bunch of rules in
audit.rules  to accomplish the same objective ?

Possibly a dumb question, so apologize in advance, but other than Policy
Enforcement and Prevention in the 'Enforcing' mode (which I cant use in
my product for various reasons), what else is SELinux buying me, that I
cant get by using just audit ?

I am sure there must be significant benefits of SELinux, but can someone
help me understand some of the benefits. 

And also perhaps some of the SELinux functionalities are desirable, but
cannot be accomplished by just audit. Can you tell me what those may be?
If there is an article or URL that provides more depth, please feel free
to share that as well.

Thanks as always for your help.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
