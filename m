Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Timothy Wood <timothy@hallcomp.com>
Subject: Re: new file contexts
Date: Fri, 23 Aug 2002 18:10:09 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0208231048300.20183-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0208231048300.20183-100000@raven>
MIME-Version: 1.0
Message-Id: <20020823161010.507977CDD@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 23 Aug 2002 16:52, Stephen Smalley wrote:
> On 23 Aug 2002, Timothy Wood wrote:
> > (gnome doesn't so I don't see why ROX would).  So should I just append
> > these changes to the types.fc since that is where the generic /usr/bin
> > type is located or would it be better to leave them in the already
> > seperate rox.fc and change the Makefile?
> >
> > here are my changes:
> >
> > # ROX
> > /usr/apps/ROX-Filer/Linux-ix86/ROX-Filer		system_u:object_r:bin_t
> > /usr/apps/ROX-Session/Linux-ix86/ROX-Session		system_u:object_r:bin_t
> > /usr/apps/(.*)/AppRun		system_u:object_r:bin_t
>
> To date, we've only created a program .fc file when there is a
> corresponding program domain and have used types.fc to assign general
> types (like bin_t) to other files.  Hence, I think I would just append
> these entries to types.fc.

OTOH the Rox people could just make their package conform to the FHS...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
