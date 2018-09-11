From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ted Toth <txtoth@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
References: <CAFPpqQEgS9mqEZcMCn=3AGYer_5WBQmQdqjsMC=OJqtgwp96cQ@mail.gmail.com>
 <41fbbd99-00ef-3953-1049-acf975ae6ffa@tycho.nsa.gov>
 <CAFPpqQHXmvCNLwkW3xmYX9PWFwwmfc7wD2kOz-KKEVip-BFLyA@mail.gmail.com>
 <CAFPpqQGyUWsXwmfAybHKWhuQ6jytaNn_ZO-BfeqxNTQZDb+uvg@mail.gmail.com>
 <4e7d4090-e271-b904-c5bb-24f69304625d@tycho.nsa.gov>
 <85bb9bec-2bda-34fa-1f7d-256470c4f38c@tycho.nsa.gov>
 <CAFPpqQEw38WqjLCdHba=krGygiUqp8Z8i+UG6d4CTkg0rW9i3Q@mail.gmail.com>
 <d4404bc7-9f23-7ed6-fb2f-24c31d7e4704@tycho.nsa.gov>
Message-ID: <cff08fc3-bd9e-c90f-a632-6937c01e2225@tycho.nsa.gov>
Date: Tue, 11 Sep 2018 15:43:51 -0400
MIME-Version: 1.0
In-Reply-To: <d4404bc7-9f23-7ed6-fb2f-24c31d7e4704@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: MLS dominance check behavior on el7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/11/2018 03:29 PM, Stephen Smalley wrote:
> On 09/11/2018 02:49 PM, Ted Toth wrote:
>> Yes I too noticed the translate permission but couldn't find any info 
>> related to it intended purpose. Regarding CIL unfortunately I have 
>> zero experience with it but I've installed the compiler and started 
>> reading through https://github.com/SELinuxProject/cil/wiki (any other 
>> pointers to useful info would be appreciated). I have written lots of 
>> policy would it be possible to add a class/permissions/mlsconstraints 
>> in an old-fashion policy module?
> 
> The older binary modules didn't support those kinds of statements 
> outside of the base module.  Try this:
> $ cat > mcstrans.cil <<EOF
> ; define a mcstrans class with one permission color_use
> (class mcstrans (color_use))
> ; allow all domains mcstrans color_use permission to themselves
> (allow domain self (mcstrans (color_use)))
> ; only allow mcstrans color_use permission when h1 dominates h2
> (mlsconstrain (mcstrans (color_use)) (dom h1 h2))
> ; append the new mcstrans class to the end after all others
> (classorder (unordered mcstrans))
> EOF
> 
> $ sudo semodule -i mcstrans.cil
> 
> Then try performing permission checks with "mcstrans" as your class and 
> "color_use" as your permission, between a domain and itself, with 
> different levels.

BTW, an easy way to find CIL syntax for something is to look at how it 
is done in the base module.  You can extract a copy of that via
semodule -c -E base, then bring up base.cil in your favorite editor/viewer.
