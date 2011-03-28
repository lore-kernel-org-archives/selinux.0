Subject: Re: [PATCH] selinux: Fix regression for Xorg
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
        qingtao.cao@windriver.com, selinux@tycho.nsa.gov
In-Reply-To: <4D8D5799.3030509@gmail.com>
References: <4D878244.4060502@gmail.com> <4D8A36E9.3070601@gmail.com>
	 <4D8AACD9.60505@gmail.com> <1300975137.8157.38.camel@moss-pluto>
	 <4D8B70C8.3000800@gmail.com> <1300997637.8157.44.camel@moss-pluto>
	 <4D8BA7F0.5090307@gmail.com> <1300998293.8157.48.camel@moss-pluto>
	 <4D8BACFD.6090400@gmail.com>  <4D8C09A3.5090304@windriver.com>
	 <1301055989.22099.4.camel@moss-pluto> <1301056481.22099.8.camel@moss-pluto>
	 <1301062423.22099.19.camel@moss-pluto>  <4D8D5799.3030509@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 28 Mar 2011 08:42:12 -0400
Message-ID: <1301316132.23818.7.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-03-25 at 20:03 -0700, Justin P. Mattock wrote:
> not sure whats going on now.. but loading up the latest on my iMac with 
> the below patch makes no difference I still hit the bug macbook pro 
> works fine(maybe something with the different video drivers or something)
> 
> full dmesg of my iMac here:
> http://fpaste.org/SNFC/

Hi Justin,

I did before and after testing using the compute_create utility from
libselinux/utils, and it showed that the kernel returned the wrong
context prior to the patch and the right context afterward.  I'm
guessing you aren't booting the right kernel or didn't apply the patch
correctly.

You can run:
compute_create `id -Z` `id -Z` x_drawable
and see whether the returned context has object_r or not.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
