Subject: Re: [PATCH] selinux: Kernel access key retention support for
	SELinux
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: David Howells <dhowells@redhat.com>
Cc: jmorris@redhat.com, selinux@tycho.nsa.gov, sds@tycho.nsa.gov
In-Reply-To: <12509.1149240105@warthog.cambridge.redhat.com>
References: <1149186390.2511.2.camel@moss-tarheels.epoch.ncsc.mil>
	 <12509.1149240105@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 08:44:37 -0400
Message-Id: <1149252277.7506.6.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-06-02 at 10:21 +0100, David Howells wrote:
> Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:
> 

> What do you mean by "soon"?  Do you mean that we don't do this at the moment,
> but will do some time in the future, or do you mean that the keyrings start
> off labelled one way, but get relabelled later on in the login process?
> 

I guess that is quite ambiguous, and there's not really any reason to
discuss our future patches in the documentation anyway.

> I think I'd also split the second paragraph a bit.
> 
> Can you also wrap the text at 80 characters please?  I won't mention that
> "labeled" should be "labelled":-)

I'm a proud American; I don't use British spelling. ;-)  Are you
serious, though?  Is there some convention about American vs. British
spelling in our section of the kernel?  I see both in the documentation.

> 
> How about this:
> 
> ---
> The security class "key" has been added to SELinux so that mandatory access
> controls can be applied to keys created within various contexts.  This support
> is preliminary, and is likely to change quite significantly in the near future.
> Currently, all of the basic permissions explained above are provided in SELinux
> as well, and are always checked before any discretionary permission checks are
> performed.

I think you meant to reverse the last sentence, but correct me if I'm
wrong...

> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
