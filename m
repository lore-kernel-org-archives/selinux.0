Message-ID: <527BFBC0.8040204@tycho.nsa.gov>
Date: Thu, 07 Nov 2013 15:44:48 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>
CC: selinux@tycho.nsa.gov
Subject: Re: review of a dbus-selinux patch
References: <1383578801.23834.59.camel@localhost>  <5277D42D.6050609@tycho.nsa.gov> <1383854250.23834.146.camel@localhost>
In-Reply-To: <1383854250.23834.146.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/07/2013 02:57 PM, Colin Walters wrote:
> On Mon, 2013-11-04 at 12:06 -0500, Stephen Smalley wrote:
> 
>> XSELinux correctly uses selinux_set_mapping() so that libselinux
>> internally creates a mapping from arbitrary class/perm indices used by
>> XSELinux and the policy values and handles all of the translation at
>> runtime on avc_has_perm() calls.
> 
> Ok, I see how this works now.  It was not obvious at all to me initially
> that the order of the #defines in XSELinux had to correspond to the
> security_class_mapping struct array.
> 
> But then I only discovered while writing a patch to document
> selinux_set_mapping() that there are man pages now for the libselinux
> API, and I guess the docs in the headers are not really used anymore?
> 
> Anyways I attached the patch...maybe it'll be useful.

Applied on #next.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
