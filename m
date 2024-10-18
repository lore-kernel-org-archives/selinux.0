Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A62188CB1
	for <selinux@vger.kernel.org>; Fri, 18 Oct 2024 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272141; cv=none; b=Ca1ic+Jz4kVCRfF/1Wjxjkw3zVu8RQR77iyXiKyxoAHo6cWZJ1sfThm9cYYGHSlgojdWKkRs+Mj2ccErMzwwW8wjXh/ggIB2d3y8vhcpGcIXBtfg3Y24VqwVToC6dEsg8PSbbochI3d3plQ03vRC82pGPogsnDTp2L49L+ghJWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272141; c=relaxed/simple;
	bh=fqi3DO6O2zRzwAqp+2MTKeBFIAJ0GDirD3cpXzna9Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cX9NGu+s3qbe2XrOECxaiQQLS0Qd9nY3X6z/6vaYTvmV937T4vu2HpjLqn5Gfh8QMxYOdNnOhnmr3vAIzuCi3wDZn7/+rKdHXUt5a3NV9ev1MDPt58rGgtfL3XyhrIzqVuJazCoR8i9lO6dQc4H7u1sq/v/Fmwde/eqYN/Wzwf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JMWg3eBG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JMWg3eBG"
Received: from [192.168.1.211] (ip68-106-0-169.ph.ph.cox.net [68.106.0.169])
	by linux.microsoft.com (Postfix) with ESMTPSA id 92BB520FEB69;
	Fri, 18 Oct 2024 10:22:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 92BB520FEB69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729272139;
	bh=kkmNYKuXSn2sl+2tAD5aWKbTza6Mo3zb1yf1eBHYyj0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JMWg3eBG1+bcZs62gMZ1CIAjVVYfHHWkniMQBnxw6OHMUesyhCm4viF6KWGVwCNf0
	 XvTy71JXU0uTFRXzwtMPO+S8QbSxs8V/hk4cOeXDpeW6+bLR5IIHf/p2wD8WuH5j8Q
	 eaw84jYHMLTwgpW43SqkMD0rSHjyhOLCfhZ3tkP8=
Message-ID: <26bb6b4c-6a5f-49c4-a9eb-9acaa8e2e1e4@linux.microsoft.com>
Date: Fri, 18 Oct 2024 10:22:18 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: selinux_set_callback for policy load not triggering
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: SELinux <selinux@vger.kernel.org>
References: <a79e0e6f-e83d-4b4b-a55c-3f2c20b93c83@linux.microsoft.com>
 <CAEjxPJ4Yby2Y9mYf-mCaFy3cPZ-Ukzs6VCQER6uB0K_UeG=wUQ@mail.gmail.com>
 <CAEjxPJ6vEf0kpOkVUcb0LY2u2svGt+8XRg_t3ywbnPa+nnY1GA@mail.gmail.com>
Content-Language: en-US
From: Matthew Sheets <masheets@linux.microsoft.com>
In-Reply-To: <CAEjxPJ6vEf0kpOkVUcb0LY2u2svGt+8XRg_t3ywbnPa+nnY1GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/18/2024 7:52 AM, Stephen Smalley wrote:
> On Fri, Oct 18, 2024 at 10:44 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>>
>> On Thu, Oct 17, 2024 at 3:42 PM Matthew Sheets
>> <masheets@linux.microsoft.com> wrote:
>>>
>>> Hi All,
>>>
>>> I am currently working on an update for dbus-broker to trigger reload of
>>> its configuration whenever an SELinux policy load event is seen.
>>>
>>> For some background dbus-broker is comprised of two major elements the
>>> launcher and the broker.  To trigger a config reload you can either send
>>> a SIGHUP to the launcher or send a message to the launcher over dbus.
>>> In most cases the launcher will be the brokers parent.
>>>
>>> Here is a link to my current PR:
>>> https://github.com/bus1/dbus-broker/pull/379
>>>
>>> In this current state things work.  The broker will see the POLICY_LOAD
>>> event and properly send a SIGHUP to its parent, but as David pointed out
>>> my initial attempt at the fix is no good since there is no guarantee
>>> that the brokers parent will be the launcher.
>>>
>>> My attempts at moving the callback registration into the launcher have
>>> been less successful.  From what my debugging has told me is that the
>>> selinux_set_callback is going through successfully and the function
>>> pointer is correctly pointing to the callback function I define.  But
>>> when I trigger a load_policy my callback function is never called.
>>>
>>> I am not familiar with how the callbacks in libselinux work under the
>>> hood so I am unsure about what could be blocking them in this situation.
>>
>> Caveat: I haven't looked deeply so take this with a grain of salt (or two).
>> There are generally two ways of discovering when policy has been reloaded:
>> 1. Create and receive notifications on a SELinux netlink socket, or
>> 2. Map the SELinux status page and poll it for updates to the policy seqno.
>>
>> Internally libselinux has switched to using the status page whenever
>> the kernel supports it since doing so is more efficient (no syscall
>> required to read it once you've mapped the page). As an aside, the
>> status page is also more easily "virtualizable" for SELinux namespaces
>> since it is per-SELinux state/namespace already (the netlink socket
>> can also be virtualized via a separate network namespace if/when my
>> namespace patches land but that requires you to unshare the network
>> namespace too).
>>
>> As far as libselinux APIs are concerned for the status page, you can
>> check for a policy reload or enforcing mode change by calling
>> selinux_status_updated() at any time after having done an initial
>> selinux_status_open(). selinux_status_updated() will call any
>> registered callbacks if enforcing mode or policy was changed, and, it
>> returns an indicator as to whether anything changed since the last
>> time it was called.
>>
>> Or if you choose to use the netlink socket and want to use the
>> libselinux APIs, you'd call avc_netlink_acquire_fd() to create and
>> take ownership of the SELinux netlink socket and then poll/select on
>> it for notifications, and upon receiving them, calling
>> avc_netlink_check_nb() to process them, including calling your
>> callbacks.
>>
>> But you have to do one of those two things in order for your callback
>> to be invoked. I assume dbus and dbus-broker are already doing one of
>> them which is why it works for them but not for the launcher.
> 
> Also, both avc_has_perm*() and selinux_check_access() internally call
> selinux_status_updated() to ensure that they are using the latest
> enforcing mode and policy. So anything using those libselinux
> functions would get the status update for free.

Just to close the loop.  With the info above I was able to trace down
that selinux_status_updated is being called by when the broker calls
selinux_check_access.  Thus triggering the callback.  The launcher has
no such check access call.  Thanks for your help Stephen.
