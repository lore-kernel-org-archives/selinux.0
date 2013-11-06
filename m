Message-ID: <527AA169.9090505@tycho.nsa.gov>
Date: Wed, 06 Nov 2013 15:07:05 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: selinux@tycho.nsa.gov
Subject: Re: No module named policycoreutils.default_encoding_utf8 ?
References: <20131104220022.GA6511@siphos.be>
In-Reply-To: <20131104220022.GA6511@siphos.be>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/04/2013 05:00 PM, Sven Vermeulen wrote:
> Hi all,
> 
> In policycoreutils-2.2.1/semanage/semanage, the first import is:
> 
> """
> import policycoreutils.default_encoding_utf8
> """
> 
> On my system (Python 2.7) this fails with:
> 
> Traceback (most recent call last):
>   File "/usr/sbin/semanage-python2.7", line 26, in <module>
>     import policycoreutils.default_encoding_utf8
> ImportError: No module named policycoreutils.default_encoding_utf8
> 
> Is this specific for a particular Python version?
> 
> I commented it out and most other things work just fine (I only have a small
> issue with audit2allow not wanting to generate refpolicy-style modules even
> though the interface_info file is - I think - up2date and is being read by
> audit2allow).

Did sepolgen-ifgen complete successfully?
Can you provide more information about how audit2allow -R is failing?
Maybe some sample input and output.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
