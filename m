Message-ID: <4628F20E.2000208@tycho.nsa.gov>
Date: Fri, 20 Apr 2007 13:02:06 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: object class discovery userland
References: <1177077717.15762.32.camel@sgc> <4628F05B.7040309@tycho.nsa.gov>
In-Reply-To: <4628F05B.7040309@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> Christopher J. PeBenito wrote:
>> 3. stop exporting class and perm indexes outside of the libraries.  Then
>> the reverse lookup wouldn't be needed.  This would involve some
>> overhauling of the libraries.
> 
> I don't think this is a good idea because of the disruption it would 
> cause with access vector processing (as passed to security_av_string() 
> and avc_has_perm()).  How do you or together strings?
> 
> Why not just cache the numbers in the library, as Karl suggested, or 
> create a parallel "class_num" or "class_index" directory with numeric 
> nodes (perhaps renaming class to class_name).
> 
> class_num/perms/1
> class_num/name
> 
> 

Sorry,
class_num/1/perms/1
class_num/1/name

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
