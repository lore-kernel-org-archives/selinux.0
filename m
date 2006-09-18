Message-ID: <450EE7D7.3030301@trustedcs.com>
Date: Mon, 18 Sep 2006 13:39:19 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <selinux@tycho.nsa.gov>, Serge Hallyn <serue@us.ibm.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: [RFC PATCH] allow range_transitions and MLS users in modules
References: <450EDC2E.50009@trustedcs.com> <1158602480.3056.12.camel@twoface.columbia.tresys.com>
In-Reply-To: <1158602480.3056.12.camel@twoface.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> On Mon, 2006-09-18 at 13:49 -0400, Darrel Goeddel wrote:
> 
>>- Add the ability to require MLS sensitivities and categories in
>>policy
>>  modules.
>>- Remove the restrictions on defining users in MLS-enabled modules.
>>- Handle range_trans_rules in modules.
>>
>>This all allows range_transition statements to be used in policy
>>modules
>>and allows definition of users in MLS policy modules.
>>
>>I haven't tested this as much as I would like, but it is working
>>nicely
>>for me.  I have built several policies (MLS, non-MLS, strict,
>>targeted,
>>etc.) and have built several modules exercising the new functionality.
>>I'd appreciate any feedback you may have at this point.
>>
> 
> what is the syntax for requiring levels? Got a sample module we can try?
> 

Here's one of my test .te files:

module darrel 1.0;

require {
	class process fork;
	class file read;
	class chr_file read;
	class lnk_file read;
	type sysadm_t, staff_t, var_run_t;
	sensitivity s3, s7, s2;
	category c100, c45, c40, c2, c120, c125;
}

type darrel_exec_t;
range_transition staff_t darrel_exec_t s2:c2,c120.c125,c40.c45,c100;
range_transition staff_t var_run_t:{file chr_file} s3:c100,c40.c45,c2,c120.c125;
range_transition staff_t var_run_t:{lnk_file} s2:c2,c40.c45,c100,c120.c125;

optional {
	require {
		type sysadm_t;
	}

	type dgo_exec_t;
	range_transition {sysadm_t staff_t} dgo_exec_t:process s3:c2,c40.c45,c100,c120.c125;
	range_transition sysadm_t dgo_exec_t s3:c2,c40.c45,c100,c120.c125;
}

require {
	sensitivity s4, s0, s15;
	category c27, c24, c22, c0, c4, c7;
	role user_r;
}

user s2_u roles user_r level s2:c2,c22 range s0 - s15:c0.c22;
user s4_u roles user_r level s4:c4,c24 range s0 - s15:c0.c24;
user s7_u roles user_r level s7:c7,c27 range s0 - s15:c0.c27;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
