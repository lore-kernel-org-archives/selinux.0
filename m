Message-ID: <4A03264D.8070201@redhat.com>
Date: Thu, 07 May 2009 14:19:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
CC: Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libsemanage: Add Ruby Bindings
References: <1241708115-30840-1-git-send-email-dpquigl@tycho.nsa.gov>	 <4A03161A.60206@manicmethod.com> <1241716271.6624.1.camel@moss-terrapins.epoch.ncsc.mil>
In-Reply-To: <1241716271.6624.1.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/07/2009 01:11 PM, David P. Quigley wrote:
> On Thu, 2009-05-07 at 13:10 -0400, Joshua Brindle wrote:
>> David P. Quigley wrote:
>>> From: David P. Quigley<dpquigl@moss-guppy.epoch.ncsc.mil>
>>>
>>> This patch adds a SWIG specification file for ruby bindings for libsemanage.
>>> The spec file is almost identical to the python SWIG file with the exception
>>> that all list generating typemaps have been removed and the python related
>>> functions have been replaced with the corresponding ruby ones. Finally the
>>> Makefile is modified to be able to build the new bindings. Something to note is
>>> that on 64-bit systems ruby.h might be found somewhere under /usr/lib64 instead
>>> of /usr/lib so LIBDIR=/usr/lib64 will be needed to build the ruby bindings from
>>> source.
>> What is going to be using these bindings?
>
> I currently have several Facter addons for Puppet that make use of them.
> We are looking into what can be done to expand Puppet's ability to
> effectively manage systems with SELinux.
>
> Dave
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
My concern with doing this patch is that we end up with puppetd being 
able to manage selinux policy directly rather then executing semanage 
command.  But for now puppetd needs to run as an unconfined domain.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
