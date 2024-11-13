Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABB01FF7C4
	for <selinux@vger.kernel.org>; Wed, 13 Nov 2024 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514028; cv=none; b=VLNMvT/mSXITdbLKTpZVZ2E7yiJTjYRECPA/pRFg4X5j1QdT1da2q+DOEG1mM+iuTWmUUDTQCm9TyXCk7WG45k9UvgQTG9VpjPTbDoGRL83A3ajMcKtM4XfMlzVvEcIpUosE4hYYefBvSXP2W2ajQJb6bVbDCvPQt4lnA6x70/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514028; c=relaxed/simple;
	bh=qHIQc5sMWh3bIFruJIU05Rhd52qxA8hFRPawyVXSwxs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=phJlLALOpj4vBMGRywXa6Bes6H8CJDwt505/6e++Pq9mnqgr9k2x7kbU/9WwQcNMuJ5idLFfoWz4yqWtDRt/hRtCtkUUJ3xt4o4sWkPbdiZ9D2P3e232sednErkWlLjlEWkBVrpTeSqwk//zgjAxDZP1YGftQWtALD+CeN/VkCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gz6dxEMF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gz6dxEMF"
Received: from [192.168.254.48] (c-73-86-61-56.hsd1.md.comcast.net [73.86.61.56])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3F90020BEBE1;
	Wed, 13 Nov 2024 08:07:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F90020BEBE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731514026;
	bh=C22C2Hbo+/6ybCvjVTLhMtpFO8TiAwFrdtQYiQAmIaE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=gz6dxEMF2qf2trho7itTa1Q4NDk7X5pVTpoWfS1x2Mv09K5rbSabP6P/+NDNuxLPW
	 O32dNptsqMAH88+1TmIuezkWtQP3Uui8oZkiwnDcJE99wDkI40gAoqBI4kwZkEM0Wz
	 35t8m3u+Ycf/7vKSAxz0BemDmJnSSlX7N0R9A7vw=
Message-ID: <8568d29a-1281-41ae-b693-2cdbff32c333@linux.microsoft.com>
Date: Wed, 13 Nov 2024 11:07:05 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: Adding a dyntrans in systemd pid1's forking
From: Chris PeBenito <chpebeni@linux.microsoft.com>
To: SELinux mailing list <selinux@vger.kernel.org>
Cc: bluca@debian.org
References: <34e77b6f-2c76-4bf9-8e3f-ac01047c952d@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <34e77b6f-2c76-4bf9-8e3f-ac01047c952d@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/6/2024 10:21 AM, Chris PeBenito wrote:
> I've recently become aware of systemd's credentials feature[1].  In a 
> nutshell, the intent is to reduce privilege in units by systemd itself 
> copying the credentials (crypto materials, passwords, though in practice 
> it could be anything) and placing it in /run/credentials, with access 
> managed by namespacing.  This is intended to eliminate the need for the 
> daemon in the unit directly accessing the data.  My concern is the 
> possibility of inadvertently leaking credentials or abuse.  i.e. putting in
> 
> LoadCredential=foobar:/etc/shadow
> 
> This illustrative, as systemd can't read shadow if it's confined, but 
> you could replace shadow with a private key or any other highly 
> confidential data systemd needs to access.  The common response to my 
> concern is systemd units should be protected at high integrity; only 
> root can modify them, etc.  However, I think we can do better to reduce 
> the possibility of errors.
> 
> I've discussed this with one of the systemd maintainers, and I'm 
> proposing this change:
> 
> 1. pid1 forks (to pidN) to run the unit, as usual.
> 2. pidN does security_compute_create() using the current domain and the 
> label of the unit to get a new domain.
> 3. pidN does setcon() to the new domain.
> 4. pidN runs the unit as per usual (including the credentials stuff)
> 
> Then we'd need to add something like this to the policy:
> 
> allow init_t httpd_initrc_t:process dyntransition;
> type_transition init_t httpd_unit_t:process httpd_initrc_t;
> 
> I have not yet prototyped this, but based on my discussion with the 
> systemd maintainers, this should be doable.  I believe the added benefit 
> is we can decompose initrc_t's privilege and maybe even reduce init_t's 
> privilege.

Hearing no objections, I've done an initial implementation:

https://github.com/systemd/systemd/compare/main...pebenito:systemd:pidN-selinux-setcon

If there is no policy in place, it does not incur new denials.  One nice 
thing I found is that the unit name is available, so I used that in the 
security_compute_create_name_raw() call.  I tested by adding the 
following systemd-networkd.service drop-in:

[Service]
LoadCredential=shadow:/etc/shadow


I added the following to the policy:

type systemd_networkd_initrc_t;
domain_type(systemd_networkd_initrc_t)
role system_r types systemd_networkd_initrc_t;
allow init_t self:process setcurrent;
domain_dyntrans_type(init_t)
allow init_t systemd_networkd_initrc_t:process dyntransition;
type_transition init_t systemd_networkd_unit_t:process 
systemd_networkd_initrc_t;
domtrans_pattern(systemd_networkd_initrc_t, systemd_networkd_exec_t, 
systemd_networkd_t)


These changes resulted in this denial:

Nov 13 15:10:54 azurelinux-vm audit[605]: AVC avc:  denied  { read } for 
  pid=605 comm="(sd-mkdcreds)" name="shadow" dev="sda2" ino=18058 
scontext=system_u:system_r:systemd_networkd_initrc_t:s0 
tcontext=system_u:object_r:shadow_t:s0 tclass=file permissive=1


The remaining policy for systemd_networkd_initrc_t would look like 
(denials summarized by audit2allow):

allow systemd_networkd_initrc_t autofs_t:dir getattr;
allow systemd_networkd_initrc_t autofs_t:filesystem unmount;
allow systemd_networkd_initrc_t bin_t:dir { getattr search };
allow systemd_networkd_initrc_t bin_t:file { execute execute_no_trans 
getattr map open read };
allow systemd_networkd_initrc_t boot_t:dir search;
allow systemd_networkd_initrc_t cgroup_t:dir { getattr search };
allow systemd_networkd_initrc_t cgroup_t:file { getattr mounton };
allow systemd_networkd_initrc_t cgroup_t:filesystem { getattr remount };
allow systemd_networkd_initrc_t device_t:dir mounton;
allow systemd_networkd_initrc_t devlog_t:sock_file write;
allow systemd_networkd_initrc_t dosfs_t:filesystem remount;
allow systemd_networkd_initrc_t fs_t:filesystem { remount unmount };
allow systemd_networkd_initrc_t home_root_t:dir { getattr mounton };
allow systemd_networkd_initrc_t init_runtime_t:dir { add_name create 
getattr mounton remove_name rmdir search write };
allow systemd_networkd_initrc_t init_t:dir search;
allow systemd_networkd_initrc_t init_t:fd use;
allow systemd_networkd_initrc_t init_t:file { getattr ioctl open read };
allow systemd_networkd_initrc_t init_t:unix_stream_socket getattr;
allow systemd_networkd_initrc_t kernel_t:unix_dgram_socket sendto;
allow systemd_networkd_initrc_t kmsg_device_t:chr_file { getattr mounton };
allow systemd_networkd_initrc_t modules_object_t:dir { getattr mounton };
allow systemd_networkd_initrc_t proc_kmsg_t:file { getattr mounton };
allow systemd_networkd_initrc_t proc_t:file { getattr open read };
allow systemd_networkd_initrc_t proc_t:filesystem { mount remount unmount };
allow systemd_networkd_initrc_t root_t:dir mounton;
allow systemd_networkd_initrc_t self:capability { dac_read_search fowner 
net_admin setgid setpcap setuid sys_resource };
allow systemd_networkd_initrc_t self:key { search setattr write };
allow systemd_networkd_initrc_t self:netlink_route_socket { bind create 
getattr getopt nlmsg_read read setopt write };
allow systemd_networkd_initrc_t self:process { getcap setcap setfscreate 
setrlimit };
allow systemd_networkd_initrc_t self:unix_dgram_socket { connect create 
getopt setopt };
allow systemd_networkd_initrc_t shell_exec_t:file getattr;
allow systemd_networkd_initrc_t sysctl_fs_t:dir { getattr mounton search };
allow systemd_networkd_initrc_t sysctl_kernel_t:dir search;
allow systemd_networkd_initrc_t sysctl_kernel_t:file { getattr ioctl 
open read };
allow systemd_networkd_initrc_t syslogd_runtime_t:dir search;
allow systemd_networkd_initrc_t systemd_networkd_runtime_t:dir { getattr 
mounton open read search watch };
allow systemd_networkd_initrc_t systemd_networkd_runtime_t:file { 
getattr open read };
allow systemd_networkd_initrc_t systemd_networkd_t:process2 nnp_transition;
### other than mounton this tmpfs dir/file access is for creating the 
/run/credentials content
allow systemd_networkd_initrc_t tmpfs_t:dir { add_name create getattr 
mounton open read remove_name search setattr write };
contents:
allow systemd_networkd_initrc_t tmpfs_t:file { create getattr open read 
rename setattr write };
allow systemd_networkd_initrc_t tmpfs_t:filesystem { mount remount 
unmount };
allow systemd_networkd_initrc_t unlabeled_t:dir mounton;
allow systemd_networkd_initrc_t user_home_dir_t:dir { getattr mounton };
allow systemd_networkd_initrc_t user_runtime_root_t:dir { getattr mounton };

This seems like a very promising way to break up initrc_t, limit 
privileges, and prevent administrator errors.  What do you think?


--
Chris
