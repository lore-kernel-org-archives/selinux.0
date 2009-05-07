Message-ID: <4A03161A.60206@manicmethod.com>
Date: Thu, 07 May 2009 13:10:50 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov,
        "David P. Quigley" <dpquigl@moss-guppy.epoch.ncsc.mil>
Subject: Re: [PATCH] libsemanage: Add Ruby Bindings
References: <1241708115-30840-1-git-send-email-dpquigl@tycho.nsa.gov>
In-Reply-To: <1241708115-30840-1-git-send-email-dpquigl@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David P. Quigley wrote:
> From: David P. Quigley <dpquigl@moss-guppy.epoch.ncsc.mil>
> 
> This patch adds a SWIG specification file for ruby bindings for libsemanage.
> The spec file is almost identical to the python SWIG file with the exception
> that all list generating typemaps have been removed and the python related
> functions have been replaced with the corresponding ruby ones. Finally the
> Makefile is modified to be able to build the new bindings. Something to note is
> that on 64-bit systems ruby.h might be found somewhere under /usr/lib64 instead
> of /usr/lib so LIBDIR=/usr/lib64 will be needed to build the ruby bindings from
> source.

What is going to be using these bindings?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
