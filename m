Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28Geq4i010794
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 11:40:52 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l28GepKa026330
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 16:40:51 GMT
Subject: Re: pyzor/spam changes in policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45F01782.4030903@redhat.com>
References: <200702261735.l1QHZrjX030675@localhost.localdomain>
	 <1173299356.10747.25.camel@sgc.columbia.tresys.com>
	 <45F01782.4030903@redhat.com>
Content-Type: text/plain
Date: Thu, 08 Mar 2007 11:41:15 -0500
Message-Id: <1173372075.29419.4.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 09:02 -0500, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> > On Mon, 2007-02-26 at 12:35 -0500, dwalsh@localhost.localdomain wrote:
> >> @@ -139,6 +148,7 @@
> >>  
> >>  	tunable_policy(`spamd_enable_home_dirs',`
> >>  		userdom_home_filetrans_generic_user_home_dir(spamd_t)
> >> +		userdom_manage_generic_user_home_dirs(spamd_t)
> >>  		userdom_manage_generic_user_home_content_dirs(spamd_t)
> >>  		userdom_manage_generic_user_home_content_files(spamd_t)
> >>  		userdom_manage_generic_user_home_content_symlinks(spamd_t)
> >>     
> >
> > I don't understand why spamd_t would be creating new top level home
> > diretories, for example the /home/myuser dir.
> >
> >   
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=203290

I think this would be the correct fix:

@@ -146,10 +146,10 @@
        files_dontaudit_read_root_files(spamd_t)
 
        tunable_policy(`spamd_enable_home_dirs',`
-               userdom_home_filetrans_generic_user_home_dir(spamd_t)
                userdom_manage_generic_user_home_content_dirs(spamd_t)
                userdom_manage_generic_user_home_content_files(spamd_t)
                userdom_manage_generic_user_home_content_symlinks(spamd_t)
+               userdom_generic_user_home_dir_filetrans_generic_user_home_content(spamd_t,dir)
        ')
 ')
 
since it is creating the ~/.spamassassin dir the filetrans
user_home_dir_t -> user_home_t was missing.  The filetrans that was in
there did home_root_t -> user_home_dir_t.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
