Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0HHoTsD023398
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2012 12:50:29 -0500
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id q0HHoSYa026750
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2012 17:50:28 GMT
Message-ID: <4F15B4E3.9030400@tresys.com>
Date: Tue, 17 Jan 2012 12:50:27 -0500
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>
CC: <selinux@tycho.nsa.gov>
Subject: Re: CIL policy - Error: Duplicate rule defined
References: <1324647643.36909.YahooMailClassic@web87016.mail.ird.yahoo.com>
In-Reply-To: <1324647643.36909.YahooMailClassic@web87016.mail.ird.yahoo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/23/2011 08:40 AM, Richard Haines wrote:
> Steve,
> I've managed to fix this problem and can now build the policy using CIL
> (with semodule) or current policy language statements (with checkpolicy)
> and they both match using apol and sediffx (apart of course from the CIL
> namespace additions).
>
> The first fix was NOT to checkout the cil integration branch as per your
> instructions in the CIL/SELinux Userspace Integration email (git checkout
> integration). This allowed the inclusion of the latest CIL fixes in master
> as I had tunable errors otherwise.
>

Yes, we've made quite a few fixes to the master branch. We still have a 
fairly big bug that we're working on (related to macros containing 
declarative statements being called multiple times), so once we get that 
fixed we'll rebase the integration branch to include the changes.

> The second fix was to comment out the 'if' statement in the
> cil_complex_symtab_insert() function in cil_symtab.c as shown below.
>
> I have not submitted this as a patch as I don't fully understand the
> logic, although it seems to involve the long 'type' names I use and
> clashing hash values.
>

Yes, there was an edge case with duplicate checking in which ordering 
was having an affect on whether or not a duplicate was found, which is 
clearly incorrect. We're working on a fix for this bug as well.

Thanks for you're interest. Hopefully we can have these bugs fixed in 
the next week or two.

> Hope this helps
> Richard
>
> -------------- Start --------------
> cil/src/cil_symtab.c code change:
>
> int cil_complex_symtab_insert(struct cil_complex_symtab *symtab,
> 			struct cil_complex_symtab_key *ckey,
> 			struct cil_complex_symtab_datum *datum)
> {
> ......
> ......
> 	for (prev = NULL, curr = symtab->htable[hash]; curr != NULL;
> 		prev = curr, curr = curr->next) {
> /*		if (ckey->key1 == curr->ckey->key1&&
> 			ckey->key2 == curr->ckey->key2&&
> 			ckey->key3 == curr->ckey->key3&&
> 			ckey->key4 == curr->ckey->key4) {
> 			rc = SEPOL_EEXIST;
> 			goto exit;
> 		}
> */
> 		if (ckey->key1 == curr->ckey->key1&&
> 			ckey->key2<  curr->ckey->key2) {
> 			break;
> 		}
> .....
>
> -------------- End ------------------
>
> --- On Thu, 8/12/11, Richard Haines<richard_c_haines@btinternet.com>  wrote:
>
>> From: Richard Haines<richard_c_haines@btinternet.com>
>> Subject: CIL policy - Error: Duplicate rule defined
>> To: "Steve Lawrence"<slawrence@tresys.com>
>> Cc: selinux@tycho.nsa.gov
>> Date: Thursday, 8 December, 2011, 14:18
>> Steve,
>>
>> The CIL policy is attached that is giving problems.
>>
>> I have this installed as the running policy so you may need
>> to change the
>> run-semanage script.
>>
>> If you run run-semodule after creating the
>> /var/lib/selinux/<policy-name>/
>> directory structure, it should install the policy okay.
>>
>> If you then edit the x_select_paste.cil file you will find
>> a comment on line 111:
>>
>> ; STEVE: Remove comment and then run run-semodule "Error:
>> Duplicate rule defined (line: 29)"
>>
>> So remove the ';' on line 112 to read:
>> (typetransition x_select_paste_t unconfined_t x_drawable
>> x_select_paste_t)
>>
>> the error should then appear. If you add/remove the ';' on
>> the other
>> typetransition statements you will get different Dup line
>> errors.
>>
>> Note after removing ';' on line 112, run-cil will still
>> build policy (remove a few more and it will also error).
>>
>> It seems to be related to the policy size as when I added
>> the booleans after Eric's suggestion I found I had to remove
>> more typetransition statements to get the policy to build.
>>
>> Thanks for your help
>> Richard
>>
>> Note I build the same policy as policy language modules
>> using checkmodule with all the type_transition statements -
>> with no errors.
>>
>>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
