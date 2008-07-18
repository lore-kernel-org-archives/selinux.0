Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6IIEGKh006361
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 14:14:16 -0400
Received: from ag-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6IIEG29014949
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 18:14:16 GMT
Received: by ag-out-0708.google.com with SMTP id 8so8406619agc.0
        for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 11:14:16 -0700 (PDT)
Message-ID: <dd18b0c30807181114y69040817u1e46c81187828055@mail.gmail.com>
Date: Fri, 18 Jul 2008 18:14:15 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Subject: Re: firefox3
Cc: "Dominick Grift" <domg472@gmail.com>, selinux@tycho.nsa.gov
In-Reply-To: <4880D687.9030509@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <dd18b0c30807171539m772f87fh64f706e8f9cf0e9e@mail.gmail.com>
	 <1216382832.8282.27.camel@sulphur.notebook.internal>
	 <dd18b0c30807180918l5883fa40pe15530585ab320f1@mail.gmail.com>
	 <4880D687.9030509@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jul 18, 2008 at 5:44 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Justin Mattock wrote:
>> On Fri, Jul 18, 2008 at 12:07 PM, Dominick Grift <domg472@gmail.com> wrote:
>>> On Thu, 2008-07-17 at 22:39 +0000, Justin Mattock wrote:
>>>> I'm trying to tighten up firefox, from what I can see over here:
>>> I do not encourage people to run Firefox as sysadm_t, and i recommend
>>> you use staff_t as your default domain. Sysadm_t is a domain specific
>>> just for sysadmin tasks. Plus sysadm_t is being (kind of) replaced by
>>> unconfined_t in the targeted policy.
>>>
>>> Also i think sysadm, user and staff do not transition once they run
>>> Firefox, but that they run Firefox in the user domain by default.
>>>
>>> In Fedora 9 only xguest_t domain by default can run Firefox in the
>>> Mozilla domain by setting the boolean.
>>>
>>> However Nsplugin is now by default confined to the nsplugin_t domain and
>>> so even though you may not transition to mozilla_t as staff or user, you
>>> will still be protected by nsplugin_t.
>>>
>>> To see in what domain Firefox is running execute ps auxZ | grep -i
>>> firefox.
>>> --
>>> Dominick Grift <domg472@gmail.com>
>>>
>>
>> Hello;
>> when doing ps I see firefox as what I had intended it
>> to be in user_r:user_t, The interesting thing that I'm seeing
>> is firefox will start under sysadm_r. when it shouldn't.
>> Now keep in mind this is something I've noticed with the new firefox3
>> the beta version of firefox3 was using gconf differently.
>> from looking at the allow rules maybe:
>> allow user_mozilla_t sysadm_gconf_home_t:dir { add_name getattr read
>> remove_name search write };
>> allow user_mozilla_t sysadm_gconf_home_t:file { append create getattr
>> read rename unlink write };
>> is what is causing sysadm to start firefox.(now from what I'm seeing
>> even though sysadm can start firefox, you can't do much with it due to the
>> rules not being defined. it's more of a question to me as to why
>> is it starting in that role. Anyways I'll have a look into my other rules
>> that might be causing this; just to be safe.
>> regards;
>>
> Is firefox defined as an application domain?  If so can sysadm_t execute
> _NOTRANS application domains?  I would bet you firefox is running as
> sysadm_t rather then sysadm_mozilla_t or sysadm_firefox_t.
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>
> iEYEARECAAYFAkiA1ocACgkQrlYvE4MpobPj6wCgnCLi7tjLTrSe/SNblfR68rIX
> LbgAoNhG+dvHqSczszz3k9IuzNUM+VcK
> =mKRC
> -----END PGP SIGNATURE-----
>

I'm not sure; below are the allow rules that I have defined
in the policy(I'm using the latest refpolicy on nubuntu)
hopefully I didn't miss any:
allow sysadm_xserver_t user_mozilla_t:shm { associate getattr read
unix_read unix_write write };
allow sysadm_xserver_t user_mozilla_tmpfs_t:file { read write };
allow user_mozilla_t apmd_t:dir { getattr search };
allow user_mozilla_t apmd_t:file read;
allow user_mozilla_t bluetooth_t:dir { getattr search };
allow user_mozilla_t bluetooth_t:file read;
allow user_mozilla_t crond_t:dir { getattr search };
allow user_mozilla_t crond_t:file read;
allow user_mozilla_t devpts_t:dir search;
allow user_mozilla_t gconf_etc_t:dir { getattr read search };
allow user_mozilla_t gconf_etc_t:file { getattr read };
allow user_mozilla_t getty_t:dir { getattr search };
allow user_mozilla_t getty_t:file read;
allow user_mozilla_t hald_t:dir { getattr search };
allow user_mozilla_t hald_t:file read;
allow user_mozilla_t init_t:dir { getattr search };
allow user_mozilla_t init_t:file read;
allow user_mozilla_t initrc_t:dir { getattr search };
allow user_mozilla_t initrc_t:file read;
allow user_mozilla_t initrc_var_run_t:dir search;
allow user_mozilla_t initrc_var_run_t:sock_file write;
allow user_mozilla_t kernel_t:dir { getattr search };
allow user_mozilla_t kernel_t:file read;
allow user_mozilla_t klogd_t:dir { getattr search };
allow user_mozilla_t klogd_t:file read;
allow user_mozilla_t lib_t:file execute_no_trans;
allow user_mozilla_t local_login_t:dir { getattr search };
allow user_mozilla_t local_login_t:file read;
allow user_mozilla_t newrole_t:dir { getattr search };
allow user_mozilla_t newrole_t:fd use;
allow user_mozilla_t newrole_t:file read;
allow user_mozilla_t newrole_t:lnk_file read;
allow user_mozilla_t staff_t:dir { getattr search };
allow user_mozilla_t staff_t:file read;
allow user_mozilla_t sysadm_gconf_home_t:dir { add_name getattr read
remove_name search write };
allow user_mozilla_t sysadm_gconf_home_t:file { append create getattr
read rename unlink write };
allow user_mozilla_t sysadm_home_dir_t:dir { getattr search };
allow user_mozilla_t sysadm_home_t:dir { add_name getattr read
remove_name search write };
allow user_mozilla_t sysadm_home_t:file { append create getattr read
rename unlink };
allow user_mozilla_t sysadm_mozilla_home_t:dir { add_name create
getattr read remove_name rmdir search write };
allow user_mozilla_t sysadm_mozilla_home_t:file { create getattr lock
read rename unlink write };
allow user_mozilla_t sysadm_mozilla_home_t:lnk_file { create unlink };
allow user_mozilla_t sysadm_sudo_t:dir { getattr search };
allow user_mozilla_t sysadm_sudo_t:file read;
allow user_mozilla_t sysadm_t:dir { getattr search };
allow user_mozilla_t sysadm_t:file read;
allow user_mozilla_t sysadm_t:lnk_file read;
allow user_mozilla_t sysadm_tty_device_t:chr_file getattr;
allow user_mozilla_t sysadm_xauth_home_t:file { getattr read };
allow user_mozilla_t sysadm_xserver_t:dir { getattr search };
allow user_mozilla_t sysadm_xserver_t:file read;
allow user_mozilla_t sysadm_xserver_t:unix_stream_socket connectto;
allow user_mozilla_t syslogd_t:dir { getattr search };
allow user_mozilla_t syslogd_t:file read;
allow user_mozilla_t system_dbusd_t:dir { getattr search };
allow user_mozilla_t system_dbusd_t:file read;
allow user_mozilla_t tmp_t:dir { add_name create remove_name rmdir
setattr write };
allow user_mozilla_t tmp_t:file { create getattr link lock read unlink write };
allow user_mozilla_t tmp_t:sock_file { create unlink write };
allow user_mozilla_t udev_t:dir { getattr search };
allow user_mozilla_t udev_t:file read;
allow user_mozilla_t user_devpts_t:chr_file { getattr ioctl read write };
allow user_mozilla_t user_t:dir { getattr search };
allow user_mozilla_t user_t:file read;
allow user_mozilla_t user_t:lnk_file read;
allow user_mozilla_t user_t:sem { associate getattr read setattr
unix_read unix_write write };
allow user_mozilla_t user_t:shm { associate getattr read setattr
unix_read unix_write write };
allow user_mozilla_t user_tmpfs_t:file { read write };
allow user_mozilla_t v4l_device_t:chr_file { read write };

################################ make enableaudit

allow user_mozilla_t security_t:dir { getattr search };
allow user_mozilla_t security_t:file read;
allow user_mozilla_t security_t:filesystem getattr;
allow user_mozilla_t selinux_config_t:dir search;
allow user_mozilla_t selinux_config_t:file { getattr read };
allow user_mozilla_t tmp_t:dir read;

Also I did an update with SID so maybe something got messed up,
or added.
regards;


-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
