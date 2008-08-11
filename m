Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7BEMGIQ010028
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 10:22:16 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7BEMFPn014784
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 14:22:15 GMT
Message-ID: <48A04B14.8050909@redhat.com>
Date: Mon, 11 Aug 2008 10:22:12 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: david@hardeman.nu, selinux@tycho.nsa.gov
Subject: Re: [patch 06/35] soundserver policy update
References: <20080804123456.679565839@hardeman.nu>	 <20080804123735.501182274@hardeman.nu>	 <1218115989.5345.8.camel@gorn.columbia.tresys.com>	 <489B1041.1060103@redhat.com> <1218460710.16773.7.camel@gorn>
In-Reply-To: <1218460710.16773.7.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Thu, 2008-08-07 at 11:09 -0400, Daniel J Walsh wrote:
>> Christopher J. PeBenito wrote:
>>> On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
>>>> plain text document attachment
>>>> (policy_modules_services_soundserver.patch)
>>>> This policy was written by Ken Yang and reviewed by Dan Walsh:
>>>> http://marc.info/?l=fedora-selinux-list&m=118561164825982&w=2
>>>> and here:
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=250453
>>>>
>>>> I updated the .fc changes to also work with Debian paths.
>>>>
>>>> Originally submitted Jul 19, refreshed to apply cleanly
>>> Comments inline
>>>
>>>> +########################################
>>>> +## <summary>
>>>> +##	All of the rules required to administrate
>>>> +##	an soundd environment
>>>> +## </summary>
>>>> +## <param name="domain">
>>>> +##	<summary>
>>>> +##	Domain allowed access.
>>>> +##	</summary>
>>>> +## </param>
>>>> +## <param name="role">
>>>> +##	<summary>
>>>> +##	The role to be allowed to manage the soundd domain.
>>>> +##	</summary>
>>>> +## </param>
>>>> +## <param name="terminal">
>>>> +##	<summary>
>>>> +##	The type of the user terminal.
>>>> +##	</summary>
>>>> +## </param>
>>>> +## <rolecap/>
>>>> +#
>>>> +interface(`soundserver_admin',`
>>>> +	gen_require(`
>>>> +		type soundd_t;
>>>> +		type soundd_script_exec_t;
>>>> +		type soundd_etc_t;
>>>> +		type soundd_tmp_t;
>>>> +		type soundd_var_run_t;
>>>> +	')
>>>> +
>>>> +	allow $1 soundd_t:process { ptrace signal_perms getattr };
>>>> +	read_files_pattern($1, soundd_t, soundd_t)
>>>> +
>>>> +	# Allow soundd_t to restart the apache service
>>>> +	soundserver_script_domtrans($1)
>>>> +	domain_system_change_exemption($1)
>>>> +	role_transition $2 soundd_script_exec_t system_r;
>>>> +	allow $2 system_r;
>>>> +
>>>> +	files_list_tmp($1)
>>>> +        manage_all_pattern($1,soundd_tmp_t)
>>>> +
>>>> +	files_list_etc($1)
>>>> +        manage_all_pattern($1,soundd_etc_t)
>>>> +
>>>> +	files_list_pids($1)
>>>> +        manage_all_pattern($1,soundd_var_run_t)
>>>> +')
>>> This interface need several fixes.  The XML does not match.  There are
>>> whitespace issues (there should be tabs, not 8 spaces).  Also spaces
>>> after commas (other places in the patch too).  Manage_all_pattern
>>> doesn't exist upstream, and I don't plan on ever adding it.
>>>
>> Why not?  If I am an admin of a domain, I should be able to modify the
>> labeling on all types that are in that domain, on the entire class of
>> objects in that domain. Making me add all of the rules for each type is
>> just prone to errors.
>>
>> Without this rule you need to add
>>         manage_dirs_pattern($1,$2,$2)
>>         manage_files_pattern($1,$2,$2)
>>         manage_lnk_files_pattern($1,$2,$2)
>>         manage_fifo_files_pattern($1,$2,$2)
>>         manage_sock_files_pattern($1,$2,$2)
>>
>>         relabelto_dirs_pattern($1,$2,$2)
>>         relabelto_files_pattern($1,$2,$2)
>>         relabelto_lnk_files_pattern($1,$2,$2)
>>         relabelto_fifo_files_pattern($1,$2,$2)
>>         relabelto_sock_files_pattern($1,$2,$2)
>>
>>         relabelfrom_dirs_pattern($1,$2,$2)
>>         relabelfrom_files_pattern($1,$2,$2)
>>         relabelfrom_lnk_files_pattern($1,$2,$2)
>>         relabelfrom_fifo_files_pattern($1,$2,$2)
>>         relabelfrom_sock_files_pattern($1,$2,$2)
>>
>> For every type, which is nuts.
> 
> It is nuts because I don't think all that access should be provided.
> Neglecting that, "manage" in refpolicy does not imply any relabeling
> permissions.  Also the second and third blocks could be merged with
> relabel_*_pattern().
> 

define(`admin_pattern',`
        manage_dirs_pattern($1,$2,$2)
        manage_files_pattern($1,$2,$2)
        manage_lnk_files_pattern($1,$2,$2)
        manage_fifo_files_pattern($1,$2,$2)
        manage_sock_files_pattern($1,$2,$2)

        relabel_dirs_pattern($1,$2,$2)
        relabel_files_pattern($1,$2,$2)
        relabel_lnk_files_pattern($1,$2,$2)
        relabel_fifo_files_pattern($1,$2,$2)
        relabel_sock_files_pattern($1,$2,$2)

')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
