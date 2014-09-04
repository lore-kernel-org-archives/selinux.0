Message-ID: <540877F6.9050000@tycho.nsa.gov>
Date: Thu, 04 Sep 2014 10:32:22 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>,
 Richard Haines <richard_c_haines@btinternet.com>,
 selinux list <selinux@tycho.nsa.gov>
Subject: Re: SELinux Userspace Release 2014-08-26-rc2 HLL/CIL query
References: <1409836477.67254.YahooMailNeo@web87902.mail.ir2.yahoo.com>
 <54086CBA.2020602@tresys.com>
In-Reply-To: <54086CBA.2020602@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/04/2014 09:44 AM, Steve Lawrence wrote:
> On 09/04/2014 09:14 AM, Richard Haines wrote:
>> I've been attempting to convert a monolithic policy (really a modular base policy with
>> no modules) to CIL, however it fails with:
>>
>> Failed to resolve roletype statement at XX of /var/lib/selinux/modular-test/tmp/modules/400/base/cil
>>
>> when running: semodule -s modular-test -i base.pp
>>
>>
>> The cause of this appears to be the following in policycoreutils/hll/pp/pp.c where the role
>> statement is ignored for the base policy:
>>
>>
>>      case ROLE_ROLE:
>>          if (scope == SCOPE_DECL) {
>>              if (pdb->policy_type == SEPOL_POLICY_MOD) {
>>                  // roles are defined twice, once in a module and once in base.
>>                  // CIL doesn't allow duplicate declarations, so only take the
>>                  // roles defined in the modules
>>                  cil_println(indent, "(role %s)", key);
>>
>> Question: Should these type of policies be supported, if so should the CIL compiler
>> cope with duplicate role statements or the conversion service modified to remove duplicates.
>> Also there is a bug in that the CIL module is deleted from the tmp directory so you cannot
>> view the failed conversion.
>>
>> I built the CIL module using pp directly  (cat base.pp | ./pp > base.cil), then added the
>> (role ...) statement, this compiled okay using secilc.
>>
>
> When working on a bug reported by Sven, we actually came across some
> problems with how roles and roletypes are converted from pp to CIL.
> We're working on those fixes now.
>
> Regarding the duplicate role definition issue, it's kindof tricky. The
> current pp2cil conversion doesn't know anything about other modules, so
> it isn't capable of determining if two separate modules have a duplicate
> role definition. So we either have to 1) allow duplicate role
> definitions in CIL (though, we don't currently allow any duplicate
> definitions of anything) or 2) consider policies that have duplicate
> roles invalid. I don't really like either solution, need to think about
> this some more...
>

I don't want to allow duplicate declarations as a normal part of CIL, but maybe 
there could be a command line option that would just display a warning and 
ignore a duplicate declaration. I will have to think about the ramifications of 
this. I am worried that there will be corner cases were the generated kernel 
policy will be different depending on which duplicate is ignored.

> As far as how to get better information for why a CIL module failed,
> this is something we've thought about, and may be something we can
> improve in the future. Right now you have to extract the HLL module from
> the store and compile it your self. We're aware that's not particularly
> user friendly.
>
> - Steve
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
