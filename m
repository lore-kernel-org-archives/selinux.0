Message-ID: <430F1879.8060409@redhat.com>
Date: Fri, 26 Aug 2005 09:26:17 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Chad Hanson <chanson@TrustedCS.com>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>,
   "''''SE Linux ' ' ' '" <selinux@tycho.nsa.gov>
Subject: Re: Ok I plead ignorance to the way MLS works.
References: <36282A1733C57546BE392885C06185920572FD@chaos.tcs.tcs-sec.com> <1125059868.5812.58.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1125059868.5812.58.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Thu, 2005-08-25 at 17:04 -0400, Chad Hanson wrote:
>  
>
>>Ok, I'll plead MCS ignorance :) I understand the clearance will be used for
>>read/write access. Should all system services have access to all files? If
>>not a runcon or range transition would need to occur before the service
>>starts. For a particular desktop/user session pam should reduce the
>>clearance to the desired value/range. How far off am I here?
>>    
>>
>
>As I understand it, most system services should not have access to all
>categories in MCS, although some services (cups?) may require such
>access.   Hence, either starting kernel_t with a clearance that has no
>categories or shedding them upon init seemed preferable, then using a
>range_transition to regain them for specific services and login
>processes.  
>
>  
>
Yes, a few will need clearance.  Cups, Amanda, Login programs.  Then 
some will eventually need a way  where the
admin can add clearance.  IE A web server on a private network that can 
display patient records.


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
