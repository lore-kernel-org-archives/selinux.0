Subject: Re: [RFC] Split up policycoreutils
To: Sven Vermeulen <sven.j.vermeulen@gmail.com>,
 SELinux <selinux@tycho.nsa.gov>
References: <4633f93f-9a5e-65e8-12d6-f11160be316f@tycho.nsa.gov>
 <c9ef14f5-1062-21a5-e5ef-d6746a1868d8@ieee.org>
 <db994f8e-27d9-7554-56f5-beb217274d1b@tycho.nsa.gov>
 <3c579f68-4125-c2e2-a2d9-6d801f7f7de9@tycho.nsa.gov>
 <CAPzO=Nz0V58vgM_1m7sZ2yYLe-YCEf9f06vRMCyRV6Xixw5XhA@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3348bff8-b3ce-161f-e802-9fbbe87e0d76@tycho.nsa.gov>
Date: Mon, 31 Oct 2016 10:29:20 -0400
MIME-Version: 1.0
In-Reply-To: <CAPzO=Nz0V58vgM_1m7sZ2yYLe-YCEf9f06vRMCyRV6Xixw5XhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/31/2016 05:27 AM, Sven Vermeulen wrote:
> On Oct 24, 2016 3:19 PM, "Stephen Smalley" <sds@tycho.nsa.gov
> <mailto:sds@tycho.nsa.gov>> wrote:
>> We'd also need to move chcat, since it imports seobject.  However, on
>> that topic, is there any reason to retain chcat?  It was created for the
>> original discretionary MCS model and I'm not sure it is used anymore by
>> anyone.
> 
> I am aware of at least one company using chcat. However, I don't know to
> what extend they rely on it - they use it in their user provisioning
> scripts.
> 
> I don't mind getting rid of it, assuming all its functionality is
> covered elsewhere. Especially using the tool(s) in unattended scripts.

I think that for that situation chcat is just invoking semanage login
with appropriate arguments, so you could just directly invoke semanage.
