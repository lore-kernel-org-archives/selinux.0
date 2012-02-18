Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1IF2gkY019064
	for <selinux@tycho.nsa.gov>; Sat, 18 Feb 2012 10:02:42 -0500
Message-ID: <SNT139-W2532C1EC901A78581F23C6AB600@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_1350f4f6-0468-444f-ab61-53d97b7e3102_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <martin@martinorr.name>, <selinux@tycho.nsa.gov>
Subject: RE: role_fix_callback assertion with sysadm in base - base VS
 loadable module
Date: Sat, 18 Feb 2012 15:02:23 +0000
In-Reply-To: <20120209225847.969915sba4w431r4@webmail.tuffmail.net>
References: <20120209225847.969915sba4w431r4@webmail.tuffmail.net>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_1350f4f6-0468-444f-ab61-53d97b7e3102_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


So far I am not 100% sure, but I am extra sure that certain cautions must be taken when requiring a module to be built into base.pp rather than as loadable module. In particular, while building the base module the "self_contained_policy" macro is defined, exactly the same as when building a monolithic policy image, which will influence if the gen_require() macro would be properly expanded to the "require" keyword. Below is the definition of the gen_require() macro:

define(`gen_require',`
        ifdef(`self_contained_policy',`
                ifdef(`__in_optional_policy',`
                        require {
                                $1
                        } # end require
                ')
        ',`
                require {
                        $1
                } # end require
        ')
')

Where we can clearly see that if the "self_contained_policy" is defined,  ONLY WHEN the "__in_optional_policy" is also defined, would gen_require() be expaned to the require keyword. BTW, "__in_optional_policy" is defined only within an optional_policy() block.

That's why I take it for granted that you would have to include the actual definition of a role attribute along with the module that requires it into the base module.

Cheers,
Harry


> Date: Thu, 9 Feb 2012 22:58:47 +0000
> From: martin@martinorr.name
> To: selinux@tycho.nsa.gov
> Subject: role_fix_callback assertion with sysadm in base
> 
> I tried to build latest git refpolicy (6da98efd) using latest  
> checkpolicy and libsepol (339f8079) with the attached modules.conf.   
> In particular this puts sysadm into base.pp, and minimal other things.  
>   I get the following error.
> 
> Compiling refpolicy base module
> /usr/bin/checkmodule base.conf -o tmp/base.mod
> /usr/bin/checkmodule:  loading policy configuration from base.conf
> checkmodule: expand.c:700: role_fix_callback: Assertion `new_role !=  
> ((void *)0) && new_role->flavor == 1' failed.
> make: *** [tmp/base.mod] Aborted
> 
> -- 
> Martin Orr
 		 	   		  
--_1350f4f6-0468-444f-ab61-53d97b7e3102_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Î¢ÈíÑÅºÚ
}
--></style></head>
<body class='hmmessage'><div dir='ltr'>
So far I am not 100% sure, but I am extra sure that certain cautions must be taken when requiring a module to be built into base.pp rather than as loadable module. In particular, while building the base module the "self_contained_policy" macro is defined, exactly the same as when building a monolithic policy image, which will influence if the gen_require() macro would be properly expanded to the "require" keyword. Below is the definition of the gen_require() macro:<br><br>define(`gen_require',`<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ifdef(`self_contained_policy',`<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ifdef(`__in_optional_policy',`<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; require {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } # end require<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ')<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ',`<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; require {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } # end require<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ')<br>')<br><br>Where we can clearly see that if the "self_contained_policy" is defined,&nbsp; ONLY WHEN the "__in_optional_policy" is also defined, would gen_require() be expaned to the require keyword. BTW, "__in_optional_policy" is defined only within an optional_policy() block!
 .<br><br

>That's why I take it for granted that you would have to include the actual definition of a role attribute along with the module that requires it into the base module.<br><br>Cheers,<br>Harry<br><br><br><div><div id="SkyDrivePlaceholder"></div>&gt; Date: Thu, 9 Feb 2012 22:58:47 +0000<br>&gt; From: martin@martinorr.name<br>&gt; To: selinux@tycho.nsa.gov<br>&gt; Subject: role_fix_callback assertion with sysadm in base<br>&gt; <br>&gt; I tried to build latest git refpolicy (6da98efd) using latest  <br>&gt; checkpolicy and libsepol (339f8079) with the attached modules.conf.   <br>&gt; In particular this puts sysadm into base.pp, and minimal other things.  <br>&gt;   I get the following error.<br>&gt; <br>&gt; Compiling refpolicy base module<br>&gt; /usr/bin/checkmodule base.conf -o tmp/base.mod<br>&gt; /usr/bin/checkmodule:  loading policy configuration from base.conf<br>&gt; checkmodule: expand.c:700: role_fix_callback: Assertion `new_role !=  <br>&gt; ((void *)0) &amp;&amp; new_role-&gt;flavor == 1' failed.<br>&gt; make: *** [tmp/base.mod] Aborted<br>&gt; <br>&gt; -- <br>&gt; Martin Orr<br></div> 		 	   		  </div></body>
</html>
--_1350f4f6-0468-444f-ab61-53d97b7e3102_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
