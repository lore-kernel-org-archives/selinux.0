MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: file(1)
Date: Fri, 28 Mar 2008 21:55:50 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158801CD1E91@exchange.columbia.tresys.com>
In-Reply-To: <200803291249.25936.russell@coker.com.au>
References: <200803272349.32854.russell@coker.com.au> <200803291219.12623.russell@coker.com.au> <6FE441CD9F0C0C479F2D88F959B0158801CD1E90@exchange.columbia.tresys.com> <200803291249.25936.russell@coker.com.au>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <russell@coker.com.au>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, "SE-Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Russell Coker [mailto:russell@coker.com.au] 
> Sent: Friday, March 28, 2008 9:49 PM
> To: Joshua Brindle
> Cc: Stephen Smalley; SE-Linux
> Subject: Re: file(1)
> 
> On Saturday 29 March 2008 12:21, "Joshua Brindle" 
> <jbrindle@tresys.com> wrote:
> > Which is fine, but it just won't be useful for future modules.
> 
> Would it be possible to try and make things work well with 
> file(1) when designing future module formats?  Little things 
> like zero terminating strings really help.
>

We want modules to be user editable using standard editors so no binary
data will be used..
Unless file will be able to find the first non-comment line I'm not sure
how it'll work.
 
> The magic database has entries for systems that were EOL'd 
> 15+ years ago, so we will of course keep adding entries for 
> these formats.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
