Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: New SuSE rules -- opt file type
Date: Fri, 2 Aug 2002 13:33:56 +0200
References: <200208010657.GAA28694@jazzband.ncsc.mil> <20020801195618.D8D9D76C7@lyta.coker.com.au> <20020802112058.6D33EFA93@ivanova.coker.com.au>
In-Reply-To: <20020802112058.6D33EFA93@ivanova.coker.com.au>
MIME-Version: 1.0
Message-Id: <20020802113357.98388181@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2 Aug 2002 13:20, Carsten Grohmann wrote:
> Am Donnerstag, 1. August 2002 21:56 schrieb Russell Coker:
> > > > > # Access to file_t (/opt)
> > > > > allow ldconfig_t file_t:dir { getattr read search };
> > > > > allow ldconfig_t file_t:{ file lnk_file } { getattr read };
> > > >
> > > > You should never grant anything access to file_t.  The existance of
> > > > file_t labelled objects indicates a deficiency in yout file_contexts.
> > >
> > > The NSA distribution have not a type for /opt. Next days I will send a
> > > patch to correct this.
> >
> > I suggest making opt root_t as it's likely to be the root of a different
> > file system (and it's not something you'll restrict access to unless
> > you're restricting access to the root directory).  Then have rules
> > labelling /opt/.*/bin(|/.*) bin_t, etc.
>
> Why root_t?

In what way is my explanation in the preceeding paragraph unclear?

> The standard policy labled follow directories as file_t:
> opt, swap, mnt and some links.

What is "swap" directory?

Nothing should have type file_t on a properly configured system.  Any 
existance of file_t indicates inadequacies in the file_contexts.

> This entries should be not labelling in the same type. If several file
> system entries have the same security context, I need only grand access to
> one directory and all other can also access. That's why I think we should
> use different types.

In what situation might you want to grant access to / but not /opt?
In what situation might you want to grant access to /opt but not /?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
