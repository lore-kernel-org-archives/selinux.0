Message-ID: <4864D44E.8010505@redhat.com>
Date: Fri, 27 Jun 2008 07:51:42 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: Joshua Brindle <method@manicmethod.com>,
        Chad Hanson <chanson@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: releasibility in mcstransd
References: <484D91BB.3080904@manicmethod.com> <D709A20F2164C84E8B7014B0301F5EF8012E7F23@HAVOC.tcs-sec.com> <0D76DBC9-5AF4-43C4-8F38-3B7BAD9F2A1F@nall.com> <485BCED3.9020903@manicmethod.com> <FBDB910C-1B8E-4DCD-A427-6EF0B161F329@nall.com> <485BF64E.9060905@manicmethod.com> <924BE11D-328B-49B1-B793-59D96D5FA4A0@nall.com>
In-Reply-To: <924BE11D-328B-49B1-B793-59D96D5FA4A0@nall.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joe Nall wrote:
> 
> On Jun 20, 2008, at 1:26 PM, Joshua Brindle wrote:
> 
>> What about semanage? Is it doing translations without calling the
>> translation interfaces that talk to the server?
> 
> semanage translation munges the setrans.conf in an incompatible way.
> 
> It assumes a 1 to 1 translation model. It could possibly be made to work
> with some file name conventions.
> 
> joe
> 
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
We can change the semanage interface or drop it if this is too complicated.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
