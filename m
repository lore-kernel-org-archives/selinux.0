Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>,
        Vanuxem =?iso-8859-1?q?gr=E9gory?= <gvanuxem@club-internet.fr>
Subject: Re: BUGS for mlstrusted*
Date: Mon, 10 Jun 2002 19:25:33 +0200
Cc: SELinux Mailing <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0206101218400.13767-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0206101218400.13767-100000@raven>
MIME-Version: 1.0
Message-Id: <20020610172533.7DB1B72@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 10 Jun 2002 18:33, Stephen Smalley wrote:
> On Fri, 7 Jun 2002, [iso-8859-1] Vanuxem grégory wrote:
> >  In the configurations files, if
> >  we make typo errors like "mlstrustedreeeder",
> >  the checkpolicy compile and load the new policydb !!!
>
> declaration.  Hence, from the policy compiler's point of view,
> mlstrustedreeeder is a perfectly legitimate type attribute that has no
> relationship to the MLS policy.
>
> If you want the compiler to catch such errors, then the language would
> need to be changed to require that type attributes be explicitly declared.
> This would not only catch errors with typos in the MLS-relevant type
> attributes but also in any type attribute.  David Wheeler previously
> suggested adding such declarations in order to permit such checking.  We
> could do this, at the cost of breaking existing configurations.

Sounds good to me!  It would not only allow catching more errors in the 
compiler, but it would make what is going on clearer to a new policy author.  
Finally when I'm using grep to make sense of someone else's policy files 
having everything explicitely declared will make it much easier for me!

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
