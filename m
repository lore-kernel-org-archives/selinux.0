Message-ID: <4235F2A9.4090003@redhat.com>
Date: Mon, 14 Mar 2005 15:23:05 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: ivg2@cornell.edu
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: user_trans/user_trans_boolean macro
References: <1110692016.29852.77.camel@cobra.ivg2.net>	 <1110804353.21378.8.camel@moss-spartans.epoch.ncsc.mil>	 <1110820329.16850.8.camel@cobra.ivg2.net>	 <1110820795.21378.141.camel@moss-spartans.epoch.ncsc.mil> <1110824019.16850.19.camel@cobra.ivg2.net>
In-Reply-To: <1110824019.16850.19.camel@cobra.ivg2.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>Ok, how about this instead - seems more useful
>
>1) Renamed: user_trans -> allow_trans
>2) Added role as a separate argument for flexibility
>3) Remove boolean macro - declare boolean in the app .te file
>
>#####################################################
>#
># allow_trans(prefix, role_prefix, app_prefix)
>#
># Transition user:$2_r:$1_t to user:$2_r:$1_$3_t
>#
>define(`allow_trans', `
>role $2_r types $1_$3_t;
>if (! disable_$1_$3_transition) {
>domain_auto_trans($1_t, $3_exec_t, $1_$3_t)
>}
>')
>
>  
>
disable_$1_transition is so the admin can decide if they want certain 
users to transition. 
For example, I think we should have a locked down mozilla policy where 
it only shows
web pages and only allows you do download to /tmp or My Downloads.    It 
should not be
allowed to touch the users home directory.  This should be the only 
mozilla policy, and the
admin gets the ability to turn on/off the policy.  So if you want to be 
protected by Mozilla
policy you give up alot of its functionality otherwise you run it as 
user_t.  The way Mozilla
was policy is going is we end up with user_t privs anyways.  I don't 
think we need a boolean
for each role though.  IE I think the exposion of booleans is worse the 
the loss of customizability.

So one disable_mozilla_trans is better than disable_user_mozilla_trans.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
