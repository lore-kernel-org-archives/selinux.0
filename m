Message-ID: <1342038224.29461.83.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: The order of policies in file "seapp_context"
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Wed, 11 Jul 2012 16:23:44 -0400
In-Reply-To: <CAO-4OdF09d2sC0y3yFxH81DXAtcGPMhxMLMs9-SYTaJW=CgDhQ@mail.gmail.com>
References: 
	<CAO-4OdF09d2sC0y3yFxH81DXAtcGPMhxMLMs9-SYTaJW=CgDhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-07-11 at 13:22 -0700, Haiqing Jiang wrote:
> Hi, all,
> 
> 
> According to the "Precedence Rules" of seapp contexts, the order of
> all the policies should follow:
> #         (1) isSystemServer=true before isSystemServer=false.
> #         (2) Specified user= string before unspecified user= string.
> #         (3) Fixed user= string before user= prefix (i.e. ending in
> *).
> #         (4) Longer user= prefix before shorter user= prefix. 
> #         (5) Specified seinfo= string before unspecified seinfo=
> string.
> #         (6) Specified name= string before unspecified name= string.
> 
> 
> So, I don't think the current order is correct. 
> 
> 
> isSystemServer=true domain=system
> user=system domain=system_app type=system_data_file
> user=nfc domain=nfc type=nfc_data_file
> user=radio domain=radio type=radio_data_file
> user=app_* domain=untrusted_app type=app_data_file levelFromUid=true
> user=app_* seinfo=platform domain=platform_app levelFromUid=true
> user=app_* seinfo=shared domain=shared_app levelFromUid=true
> user=app_* seinfo=media domain=media_app levelFromUid=true
> user=app_* seinfo=release domain=release_app levelFromUid=true
> user=app_* seinfo=release name=com.android.browser domain=browser_app
> levelFromUid=true
> 
> 
> For example, "user=app_* domain=untrusted_app type=app_data_file
> levelFromUid=true" should
> be the last one. And "user=app_* seinfo=release domain=release_app
> levelFromUid=true" should 
> follow behind "user=app_* seinfo=release name=com.android.browser
> domain=browser_app levelFromUid=true".   
> 
> 
> Could you help me to clarify that???? Thanks a lot. 

We don't care about the order of entries within the file; the code sorts
them based on those precedence rules to ensure the best match.  The code
is in external/libselinux/src/android.c, ordered by the
seapp_context_cmp() function.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
