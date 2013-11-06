MIME-Version: 1.0
In-Reply-To: <5277B25A.7030105@redhat.com>
References: <52715E75.5000005@redhat.com>
	<527168B1.4040905@tycho.nsa.gov>
	<52716DE6.8040401@redhat.com>
	<CAPzO=NyM2K5zb3DemGOxCFVU3dwuFDjo23AgtxS=oSwxrFdDxA@mail.gmail.com>
	<5277B25A.7030105@redhat.com>
Date: Wed, 6 Nov 2013 16:35:19 +0100
Message-ID: <CAPzO=NwDTKKxx5KsT0X+R57vqPz4aDdrmoRV-f4DiowjQNi_2Q@mail.gmail.com>
Subject: Re: Been looking at further shrinkage of the SELinux footprint on Linux.
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 4, 2013 at 3:42 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>> In Gentoo, we try to only install the SELinux policies related to the
>> package that is installed. So if a system does not have a web server, no
>> httpd policies are loaded.
[...]
> And how do  you handle the problem of removing policy when packages get
> removed?  What happens to the programs content?

Good point. We don't handle that - if the package is removed and no
other package exists that has a dependency on the SELinux policy, then
the SELinux policy is also removed. Which invalidates the contexts of
the files. I reckon that users who hit issues with that would relabel
the files, which usually labels them to the "parent" type (such as
var_t for things in /var/www then). But I have not received such
case(s) for review yet.

Wkr,
  Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
