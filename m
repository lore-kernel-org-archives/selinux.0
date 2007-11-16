Message-ID: <473DE3DC.9080308@tycho.nsa.gov>
Date: Fri, 16 Nov 2007 13:39:24 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Fix fixfiles handling of arguments
References: <473DBE35.7050206@redhat.com>
In-Reply-To: <473DBE35.7050206@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> fixfiles restore /usr/bin/g*
>
> goes nuts.
>
> This patch fixes this.
>   

Is the "echo broken" line supposed to be there?


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
