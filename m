Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6PFgOHQ001163
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2011 11:42:24 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p6PFgM3a003506
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2011 15:42:23 GMT
Message-ID: <4E2D8EDD.4070909@tresys.com>
Date: Mon, 25 Jul 2011 11:42:21 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Harry Ciao <qingtao.cao@windriver.com>
CC: <cpebenito@tresys.com>, <method@manicmethod.com>, <selinux@tycho.nsa.gov>
Subject: Re: v4 Add role attribute support to libsepol
References: <1311557039-2977-1-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1311557039-2977-1-git-send-email-qingtao.cao@windriver.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/24/2011 09:23 PM, Harry Ciao wrote:
> 
> 
> Differences from v3 patchset
> -----------------------------
> 1. For the 0002 patch, 
>    Introduce MOD_POLICYDB_VERSION_ROLEATTRIB(== 13) and bump
>    MOD_POLICYDB_VERSION_MAX to it.
> 
>    When read from or write to pp, take care of the flavor flag and roles
>    ebitmap only when the pp's version is no less than
>    MOD_POLICYDB_VERSION_ROLEATTRIB.
>    
>   
> Tests I've done
> -----------------
> 0. Build tests:
>    . revert this patchset, re-install libsepol/checkpolicy packages and
>      build modules(have no flavor/roles); apply this patchset, re-install
>      everything, the updated tools could handle old version modules in a
>      decent manner.
>    
>    . in write_binary_policy() in checkmodule.c, trigger policy module
>      downgrade by adding "policyvers = MOD_POLICYDB_VERSION_MAX - 1"; apply
>      this patchset, the updated tools could generate and process old version
>      modules correctly.
> 
> 1. test_t is able to transition into rpm_t, but could not direclty transition
>    into rpm_script_t, semanage_t, load_policy_t/setfiles_t:
>    
>    sh-3.2# sesearch -SCA -s test_t -t rpm_t -c process -p transition
>    Found 1 semantic av rules:
>       allow test_t rpm_t : process transition ; 
>    
>    sh-3.2# sesearch -SCA -s test_t -t rpm_script_t -c process -p transition
>    
>    sh-3.2# sesearch -SCA -s test_t -t semanage_t -c process -p transition
>    
>    sh-3.2# sesearch -SCA -s test_t -t load_policy_t -c process -p transition
>    
>    sh-3.2# sesearch -SCA -s test_t -t setfiles_t -c process -p transition
>    
> 2. rpm_t is able to transition into rpm_script_t, but could not directly
>    transition into semanage_t, load_policy_t/setfiles_t:
>    
>    sh-3.2# sesearch -SCA -s rpm_t -t rpm_script_t -c process -p transition
>    Found 1 semantic av rules:
>       allow rpm_t rpm_script_t : process transition ; 
>    
>    sh-3.2# sesearch -SCA -s rpm_t -t semanage_t -c process -p transition
>    
>    sh-3.2# sesearch -SCA -s rpm_t -t load_policy_t -c process -p transition
>    
>    sh-3.2# sesearch -SCA -s rpm_t -t setfiles_t -c process -p transition
>    
> 3. rpm_script_t is able to transition into semanage_t, but could not directly
>    transition into load_policy_t/setfiles_t:
>    
>    sh-3.2# sesearch -SCA -s rpm_script_t -t semanage_t -c process -p transition
>    Found 1 semantic av rules:
>       allow rpm_script_t semanage_t : process transition ; 
>    
>    sh-3.2# sesearch -SCA -s rpm_script_t -t load_policy_t -c process -p transition
>    
>    sh-3.2# sesearch -SCA -s rpm_script_t -t setfiles_t -c process -p transition
>    
> 4. semanage_t is able to transition into load_policy_t & setfiles_t:
>    
>    sh-3.2# sesearch -SCA -s semanage_t -t load_policy_t -c process -p transition
>    Found 1 semantic av rules:
>       allow semanage_t load_policy_t : process transition ; 
>    
>    sh-3.2# sesearch -SCA -s semanage_t -t setfiles_t -c process -p transition
>    Found 1 semantic av rules:
>       allow semanage_t setfiles_t : process transition ; 
>    
> 5. test_r is able to type with rpm_t, rpm_script_t, semanage_t, setfiles_t
>    and load_policy_t:
>    
>    sh-3.2# compute_create root:test_r:test_t:s0 system_u:object_r:rpm_exec_t:s0 process
>    root:test_r:rpm_t:s0
>    sh-3.2# 
>    
>    sh-3.2# compute_create root:test_r:rpm_script_t:s0 system_u:object_r:semanage_exec_t:s0 process
>    root:test_r:semanage_t:s0
>    sh-3.2# 
>    
>    sh-3.2# compute_create root:test_r:semanage_t:s0 system_u:object_r:setfiles_exec_t:s0 process
>    root:test_r:setfiles_t:s0
>    sh-3.2# 
>    
>    sh-3.2# compute_create root:test_r:semanage_t:s0 system_u:object_r:load_policy_exec_t:s0 process
>    root:test_r:load_policy_t:s0
>    sh-3.2# 
>    
> 6. Use the apol tool to analyze what types the test_r role could type with:
>    (Since the apol installed on Ubuntu so far only support max version .24,
>     we need to setup "policy-version = 24" in semanage.conf)
>    
>    test_r (28 types)
>        chfn_t
>        chkpwd_t
>        consoletype_t
>        ddclient_t
>        dhcpc_t
>        hostname_t
>        ifconfig_t
>        insmod_t
>        iptables_t
>        load_policy_t
>        loadkeys_t
>        netutils_t
>        newrole_t
>        pam_t
>        passwd_t
>        ping_t
>        pppd_t
>        pptp_t
>        rpm_script_t
>        rpm_t
>        semanage_t
>        setfiles_t
>        test_t
>        traceroute_t
>        updpwd_t
>        user_home_t
>        usernetctl_t
>        utempter_t
>    
>    rpm_roles (2 types)
>        rpm_script_t
>        rpm_t
>    
>    semanage_roles (3 types)
>        load_policy_t
>        semanage_t
>        setfiles_t


Applied in checkpolicy-2.0.27 and libsepol-2.0.46. Thanks.

- Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
