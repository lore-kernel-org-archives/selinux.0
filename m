Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: apache configuration etc
Date: Fri, 13 Sep 2002 11:41:58 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <200209122135.40681.russell@coker.com.au> <20020912222529.GA4111@snoopy.apana.org.au>
In-Reply-To: <20020912222529.GA4111@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <200209131141.58664.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 13 Sep 2002 00:25, Brian May wrote:
> On Thu, Sep 12, 2002 at 09:35:40PM +0200, Russell Coker wrote:
> > I think that the Apache policy should be macroised.
>
> For a good example of why it should be macroised, have a look at
> the openca stuff.
>
> I seem to recall copying large parts of the apache config, but
> it should really be shared instead.
>
> I think the same thing would apply to other CGI scripts.
>
> Especially, for instance, CGI scripts that require passwords
> to access SQL based databases, etc.

Great!  I look forward to seeing the policy you write!

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
