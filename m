Message-ID: <527A5616.3040206@tycho.nsa.gov>
Date: Wed, 06 Nov 2013 09:45:42 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>, Sven Vermeulen <sven.vermeulen@siphos.be>
Subject: Re: Patch to remove default encoding patch.
References: <52790D3E.4080701@redhat.com>
In-Reply-To: <52790D3E.4080701@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/05/2013 10:22 AM, Daniel J Walsh wrote:
> The default encoding patch, was never upstreamed.  default_encoding module
> switched python2 to always use unicode.  Potentially in some languages
> semanage will blow up when errors are reported.
> 
> The need for this patch is going away in python3, which should be the default
> in Fedora 21/22.

Pushed as policycoreutils-2.2.2.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
