Subject: Re: global name 'seinfo' is not defined
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <201203191716.19321.russell@coker.com.au>
References: <201203191716.19321.russell@coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 19 Mar 2012 08:11:48 -0400
Message-ID: <1332159108.23035.1.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-03-19 at 17:16 +1100, Russell Coker wrote:
> I'm stuck on the following error after updating the Debian packages to the 
> latest userspace.  Could someone please tell me where this "seinfo" function 
> is supposed to be defined?  I can probably work out the cause of this if I 
> could find where it's defined.

setools (setools-libs-python in Fedora).

> 
> As an aside, if someone who's good at Python wants to help out with the Debian 
> SE Linux work then that would be greatly appreciated.  Not much work is 
> required, but it's tough for people like me who generally don't do Python.
> 
> 
> # dmesg|audit2allow 
> Traceback (most recent call last):
>   File "/usr/bin/audit2allow", line 354, in <module>
>     app.main()
>   File "/usr/bin/audit2allow", line 345, in main
>     self.__output()
>   File "/usr/bin/audit2allow", line 315, in __output
>     g.add_access(self.__avs)
>   File "/usr/lib/python2.7/dist-packages/sepolgen/policygen.py", line 211, in 
> add_access
>     self.__add_allow_rules(raw_allow)
>   File "/usr/lib/python2.7/dist-packages/sepolgen/policygen.py", line 179, in 
> __add_allow_rules
>     self.domains = seinfo(ATTRIBUTE, name="domain")[0]["types"]
> NameError: global name 'seinfo' is not defined
> 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
