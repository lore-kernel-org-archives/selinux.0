Message-ID: <450F1188.9010603@redhat.com>
Date: Mon, 18 Sep 2006 17:37:12 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Steve G <linux_4ever@yahoo.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest patch for policycoreutils, reworked from previous.
References: <20060914210005.95111.qmail@web51511.mail.yahoo.com>	 <450AA9BF.1080101@redhat.com> <1158611077.14194.65.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1158611077.14194.65.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-09-15 at 09:25 -0400, Daniel J Walsh wrote:
>   
>> Reworked patch.
>>
>> restorecon -v goes back to stdout
>>
>> added "verify" to print out files with out the verbose mode.
>>     
>
> Hmm...just noticed this:
>
> diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/restorecon/restorecon.c policycoreutils-1.30.29/restorecon/restorecon.c
> --- nsapolicycoreutils/restorecon/restorecon.c	2006-09-01 22:32:11.000000000 -0400
> +++ policycoreutils-1.30.29/restorecon/restorecon.c	2006-09-15 09:19:49.000000000 -0400
> @@ -249,7 +254,10 @@
>  						freecon(scontext);
>  						return 1;
>  					}
> -				}
> +				} 
> +				else
> +					change_ctr++;
> +
>
>
> I don't think this is matching up with the right if statement; it
> currently matches if (change), so it only executes if restorecon is
> making no changes (-n option).  Looks like you meant it to match the if
> (lsetfilecon(...) < 0).
>
> <snip>
> @@ -428,5 +445,7 @@
>  	if (outfile)
>  		fclose(outfile);
>  
> +	if (change) return change_ctr;
>   
Yes this should be
if (!change) return change_ctr;


The idea is to check how many files would be changed if the tool was 
run, as opposed to whether
the tool was successful.

I agree this is a little shaky.
> +
>  	return errors;
>  }
>
> The problem here is that existing callers may assume that an exit status
> of non-zero means failure.  Again, an interface change.  How did you
> intend to use this?  
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
