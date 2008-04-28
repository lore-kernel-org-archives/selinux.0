Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3SJfSuJ024736
	for <selinux@tycho.nsa.gov>; Mon, 28 Apr 2008 15:41:28 -0400
Message-ID: <48162867.8020007@tycho.nsa.gov>
Date: Mon, 28 Apr 2008 15:41:27 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: copy/paste policy patch
References: <cadfc0e40804250607q6e6542ecmc1fa3d1e78a84cb8@mail.gmail.com>	 <481616BF.8020102@tycho.nsa.gov> <cadfc0e40804281221g40382bf4ice31d0e36c7550c4@mail.gmail.com>
In-Reply-To: <cadfc0e40804281221g40382bf4ice31d0e36c7550c4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Xavier Toth wrote:
>
>
> On Mon, Apr 28, 2008 at 1:26 PM, Eamon Walsh <ewalsh@tycho.nsa.gov 
> <mailto:ewalsh@tycho.nsa.gov>> wrote:
>
>     Xavier Toth wrote:
>
>         Here's a patch I'm using with an MLS version of glipper to
>         give the capability to check for dominance between copy and
>         paste data contexts. Hopefully some version of this can be
>         upstreamed.
>
>
>     Hi, why did you reverse the two paste operations?  In my
>     suggestion I had the "paste" bit meaning "unconditional paste" and
>     "paste_after_confirm" meaning "allow paste only after the user
>     confirms."
>
>     Having the confirmation dialog semantics built in to the plain old
>     "paste" permission seems to me like it would be more confusing,
>     and difficult to change later.
>
>
> Well maybe I didn't understand what you were thinking. I did it the 
> way I did because I use the avc_has_perm to tell me whether I need to 
> bring up the downgrade dialog.


Here is pseudo-code for the way I'd prefer to have the check done:

if (avc_has_perm(requestor's context, selection's context, X_APPLICATION_DATA, PASTE) == 0)
    // Perform the paste without asking.
   
else if (avc_has_perm(requestor's context, selection's context, X_APPLICATION_DATA, PASTE_AFTER_CONFIRM) == 0)
    // Pop up the confirmation dialog; perform the paste if user accepts.

else
    // If you get here, the paste just isn't allowed at all.



>
>
>
>
>         --- serefpolicy-3.3.1/policy/flask/access_vectors      
>         2008-04-08 13:41:18.000000000 -0500
>         +++ serefpolicy-3.3.1.new//policy/flask/access_vectors
>          2008-04-08 13:35:43.000000000 -0500
>         @@ -765,3 +765,10 @@
>          {
>                recv
>          }
>         +
>         +class x_application_data
>         +{
>         +        paste
>         +        paste_without_confirm
>         +        copy
>         +}
>         --- serefpolicy-3.3.1/policy/flask/security_classes    
>         2008-04-08 13:41:18.000000000 -0500
>         +++ serefpolicy-3.3.1.new//policy/flask/security_classes      
>          2008-04-08 13:34:36.000000000 -0500
>         @@ -114,5 +114,6 @@
>          class x_resource               # userspace
>          class x_event                  # userspace
>          class x_synthetic_event                # userspace
>         +class x_application_data        # userspace
>           # FLASK
>         --- serefpolicy-3.3.1/policy/mls        2008-04-08
>         13:41:18.000000000 -0500
>         +++ serefpolicy-3.3.1.new/policy/mls    2008-04-08
>         14:20:49.000000000 -0500
>         @@ -567,6 +567,12 @@
>                 ( t1 == mlsxwinwritexinput ) or
>                 ( t1 == mlsxwinwrite ));
>          +#
>         +# MLS policy for the x_application_data class
>         +#
>         +mlsconstrain x_application_data { paste_without_confirm }
>         +       ( l1 domby l2 );
>         +
>           #
>          # MLS policy for the pax class
>
>
>
>     -- 
>     Eamon Walsh <ewalsh@tycho.nsa.gov <mailto:ewalsh@tycho.nsa.gov>>
>     National Security Agency
>
>


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
