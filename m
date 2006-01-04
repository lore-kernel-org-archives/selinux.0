Message-ID: <43BC0832.4050108@cornell.edu>
Date: Wed, 04 Jan 2006 12:38:58 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policycoreutils latest diffs.
References: <43BAC4EA.8020106@redhat.com> <43BAB2D6.4030103@cornell.edu> <43BBF8C6.1070109@cornell.edu> <43BBFA8A.2040601@cornell.edu> <43BC1ECA.1070806@redhat.com> <43BC0681.2090403@cornell.edu> <43BC237D.4040606@tresys.com>
In-Reply-To: <43BC237D.4040606@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
> No, I think this is a bad idea, the purpose of local files is to 
> override policy defaults. The base policy package should stay the same 
> so that upgrades via RPM do not smash changes. Using an alternate base 
> if it exists and the base.pp otherwise adds unnecessary complexity.
I meant a read-only API.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
