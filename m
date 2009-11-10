Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAAMwPMB008256
	for <selinux@tycho.nsa.gov>; Tue, 10 Nov 2009 17:58:25 -0500
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id nAAN0PDc002571
	for <selinux@tycho.nsa.gov>; Tue, 10 Nov 2009 23:00:25 GMT
Date: Tue, 10 Nov 2009 17:58:23 -0500
Subject: Re: Fix boolean handling in semanage
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C71F5A3F.AFD53%csellers@tresys.com>
In-Reply-To: <4AC3A237.3050908@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 9/30/09 2:23 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> Also fix error message triggered by broken boolean handling.
> 
> diff --git a/policycoreutils/semanage/semanage
> b/policycoreutils/semanage/semanage
> index ffaca5b..437eca3 100644
> --- a/policycoreutils/semanage/semanage
> +++ b/policycoreutils/semanage/semanage
> @@ -315,6 +315,7 @@ Object-specific Options (see above):
>          
>          if object == "boolean":
>              OBJECT = seobject.booleanRecords(store)
> +                        modify = True
>          
Not sure I see what was broken here. The usage and man page say you have to
specify -d or -m to semanage boolean (which is just like all the other
subcommands). Here you're trying to make that optional, and default to -m if
not specified (unless I'm guessing wrong at your intentions). I'd be fine
with that, but you broke -d in the process:

# semanage boolean -d xen_use_nfs
Traceback (most recent call last):
  File "/usr/sbin/semanage", line 461, in <module>
    process_args(sys.argv[1:])
  File "/usr/sbin/semanage", line 370, in process_args
    OBJECT.modify(target, value, use_file)
  File "/usr/lib/python2.6/site-packages/seobject.py", line 1642, in modify
    self.__mod(name, value)
  File "/usr/lib/python2.6/site-packages/seobject.py", line 1610, in __mod
    if value.upper() in self.dict:
AttributeError: 'NoneType' object has no attribute 'upper'

>          if object == "permissive":
>              OBJECT = seobject.permissiveRecords(store)
> @@ -404,7 +405,7 @@ Object-specific Options (see above):
>  
>                          return
>  
> -                raise ValueError(_("Invalid command") % " ".join(argv))
> +                raise ValueError(_("Invalid command: semanage %s") % "
> ".join(argv))
>  
>      #
>      # 
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
