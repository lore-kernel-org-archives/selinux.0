Message-Id: <200208021119.LAA10120@jazzband.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: New SuSE rules -- opt file type
Date: Fri, 2 Aug 2002 13:20:36 +0200
References: <200208010657.GAA28694@jazzband.ncsc.mil> <20020801182445.4897EFA93@ivanova.coker.com.au> <20020801195618.D8D9D76C7@lyta.coker.com.au>
In-Reply-To: <20020801195618.D8D9D76C7@lyta.coker.com.au>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Donnerstag, 1. August 2002 21:56 schrieb Russell Coker:
> > > > # Access to file_t (/opt)
> > > > allow ldconfig_t file_t:dir { getattr read search };
> > > > allow ldconfig_t file_t:{ file lnk_file } { getattr read };
> > >
> > > You should never grant anything access to file_t.  The existance of
> > > file_t labelled objects indicates a deficiency in yout file_contexts.
> >
> > The NSA distribution have not a type for /opt. Next days I will send a
> > patch to correct this.
>
> I suggest making opt root_t as it's likely to be the root of a different
> file system (and it's not something you'll restrict access to unless
> you're restricting access to the root directory).  Then have rules
> labelling /opt/.*/bin(|/.*) bin_t, etc.

Why root_t? 
The standard policy labled follow directories as file_t:
opt, swap, mnt and some links. 
This entries should be not labelling in the same type. If several file 
system entries have the same security context, I need only grand access to 
one directory and all other can also access. That's why I think we should 
use different types. 

Carsten

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
