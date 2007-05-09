Subject: Re: Fix to genhomedircon to find conflicting directories correctly.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <463B330A.8030109@redhat.com>
References: <463B330A.8030109@redhat.com>
Content-Type: text/plain
Date: Wed, 09 May 2007 11:30:26 -0400
Message-Id: <1178724626.16433.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-05-04 at 09:20 -0400, Daniel J Walsh wrote:
> plain text document attachment (diff)
> diff --exclude-from=exclude --exclude=sepolgen-1.0.8 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/scripts/genhomedircon policycoreutils-2.0.14/scripts/genhomedircon
> --- nsapolicycoreutils/scripts/genhomedircon	2007-04-25 11:08:44.000000000 -0400
> +++ policycoreutils-2.0.14/scripts/genhomedircon	2007-05-04 09:14:57.000000000 -0400
> @@ -302,7 +302,7 @@
>  			    
>  			    regex = re.sub("\(\/\.\*\)\?", "", regex)
>  			    regex = regex + "/*$"
> -			    if re.search(home, regex, 0):
> +			    if re.search(regex,home, 0):
>  				    return 1
>  		    except:
>  			    continue

Thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
