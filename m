Received: from USG02-CY1-obe.outbound.protection.office365.us (mail-cy1usg02on0079.outbound.protection.office365.us [23.103.209.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62246196D80
	for <selinux@vger.kernel.org>; Fri,  1 Nov 2024 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.103.209.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485643; cv=fail; b=oilvvT7lq9q4AXTjgnR+w3CrJ2HAQEetBNZLHFCrqXc6c92qnRiNJc9jxGcF4PD6jXs71JvSlX0D12Lfzzh/9Zc3a2OS1PYTnFrGvZP9dL7jUBpGqxZzI9AipZAfbLlwCAd5JofDrE6tNNVyaxwufdmALeF3Ho3SJBpZWgvOVRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485643; c=relaxed/simple;
	bh=lfWk+wLd397Q1iWYrEcEQFX6/ZbK/ZE8WOcbnn60Qm8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cIIX09J9gMrC2DbCWkB0fj5uuQEPR0L0NUOpkzPSSv4HkZ3iJkc+9/VvpqesByjfdTppiewfZ5OdlfoGbUoUDgg/nfsX19LPFtGep/q6dSTTzuoOkz0nOZbCrA26RJEeefAQYHMZIWMRwpe+Z3QLwdGvCvijSOblSsuCM4nsFrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=owlcyberdefense.com; spf=pass smtp.mailfrom=owlcyberdefense.com; dkim=pass (2048-bit key) header.d=owlcyberdefense.com header.i=@owlcyberdefense.com header.b=ZA9QKxsr; arc=fail smtp.client-ip=23.103.209.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=owlcyberdefense.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=owlcyberdefense.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owlcyberdefense.com header.i=@owlcyberdefense.com header.b="ZA9QKxsr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=zeaf0uTKrojD14U4ySLf9Src5ZyvcOYNL4+r4mp/FMsOd+MnuazhU7tORgZIy0SGRqtVB0TJGCULhC6u5jjBPMYjfy+Szyt1y17z4k90YR6Vn9cLnx44uKip8WXs1nz6P6m0jsNwE8d6TXHCN8334fSs17HJu0be3cR+639hXor3os+Mrlsd5zHyqlw4DK8KaGUmIsxA3DnUUmtxOU5duuSc9ixhofpw4cdfGBJ2c8yUR5mttRz728IeBt3z6/Fu/Wgwup31U2OwSliWpb+RiuApzCXOb945rCY8IFzOntEcoKCBGSVfcPcrKCl37RGJN608/WfpiNCwqiXUy1mw/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biu6Rwe3Rqhexwf9wJsxz0x/vzLtsxC5oJHnFodZzPY=;
 b=bX0o+pLps23yWO2UPXzW4eWcRDyV3hULIea2amsrSD0/7QE7kNv/opLXBtaTzeBcoDv7N1tEZcC+Xbkasf9yz93ImutNaBki3qUM+H1J0YI3s7NdpqXfDr57uUQP8MSH1bWPOZBbyHSIwheaRdmZoBZ10ScC6O+km/Hjiid2TWRUYnnQmXTeza8vHgjd3gcoiTC8UZ7dPLyPbHrCMM8TVn7Blw4B1S+KfwLOY8ucDM88T7T0xICF51FyvsJj9Kk/H7ar6PoQhHLiu0UHCgH1Zs4yP0UILmdBnN2JYUXZdfYcd2q2uGFRzj40JfqZQVy3Nm/PrSEqD5up7/lYm5a90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=owlcyberdefense.com; dmarc=pass action=none
 header.from=owlcyberdefense.com; dkim=pass header.d=owlcyberdefense.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlcyberdefense.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biu6Rwe3Rqhexwf9wJsxz0x/vzLtsxC5oJHnFodZzPY=;
 b=ZA9QKxsr2XpTWUxp/4YkmQU0Kguvxx5QM1aOmbGHNOTbIT4fT87IVygacOnc68DCg8WlQ8NaXhVUUV5zdCU3jSuw2TWuug8cQ8SdzyGcngMI5zQUOjKQ5zk1pTMZ2dVk2uMJB6787PJbFbMy1x5hXxz994TbRPKPdWs4REPRTwpzRmu4k5FiO+/mz11D3CzoDpeokCaS/hqlZs5ENJGPr3EY94ylEXzzHI5wezFL4TNFlkWGhk7c4MR3aim8NlsmbYvF8EjBfFf3TzYzNyN41u23frmlR/wmfih6AjdPPhq7hh4n+wmruHXpE5FXzeJ8k6Kfk5274EIe7Wj+pYBe3w==
Received: from PH1P110MB1425.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:18c::10)
 by PH1P110MB1507.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:18b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.36; Fri, 1 Nov
 2024 13:54:50 +0000
Received: from PH1P110MB1425.NAMP110.PROD.OUTLOOK.COM
 ([fe80::df91:9139:7364:2df2]) by PH1P110MB1425.NAMP110.PROD.OUTLOOK.COM
 ([fe80::df91:9139:7364:2df2%5]) with mapi id 15.20.8069.031; Fri, 1 Nov 2024
 13:54:50 +0000
From: "Sloane, Brandon" <bsloane@owlcyberdefense.com>
To: SElinux list <selinux@vger.kernel.org>
Subject: Setrans ambiguous translations
Thread-Index: AQHbLGVF5gU7WkMqJU6kfZ7khZP8JQ==
Date: Fri, 1 Nov 2024 13:54:49 +0000
Message-ID:
 <PH1P110MB1425AEBEC479277527ADFA9AAC56A@PH1P110MB1425.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=owlcyberdefense.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1425:EE_|PH1P110MB1507:EE_
x-ms-office365-filtering-correlation-id: b5ea27cd-5235-46fb-496d-08dcfa7cc0fe
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|41320700013|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ylxpr/XWOX5F5uhErpHdh/pq5zZWH0OOyK5wzJQvWeILo9B+TkbGkk10py?=
 =?iso-8859-1?Q?Yp7ozv5wQyEpvCOOB17xtw0n2si/IO3iF/wElEz5YSIhvepurysV9MA0w1?=
 =?iso-8859-1?Q?ExPjZPCGB6Z/i+xvQST34dwNHBQYvuEMWtGuM9bFz/HVinbVFU8bKjrAix?=
 =?iso-8859-1?Q?iMpWqEzpZvTa5OH+UWCdbHlQQzwnSelTCscLHxqZC0tpjIHhyvIIyKDmEr?=
 =?iso-8859-1?Q?S1Yc4KdSmZgcnIbLrO+xy0HCckwiLwSdKX4i8arSs9hu43Eq4y+k7LDHa7?=
 =?iso-8859-1?Q?YZ7SmSokr7h6bFId3cbb/lKMtsscBJuumMsZu4jJLNpaM8036FQG9D2btc?=
 =?iso-8859-1?Q?LKoR2/DT3mvoNfkUQcMZdBkroL4vmY7633cCz2tDMeCNU3GpEyzRnpLtt+?=
 =?iso-8859-1?Q?5aPFtlmWHW48N8kMtM/YgY5GR9x8qWscPL6pvX/g/VzymbXPzIF/PeoORo?=
 =?iso-8859-1?Q?zjfDwhXwQfUVkP/9emVf96uDeQxQbyPVG3WeQylrJTe3W1tiqPi/z9f0EP?=
 =?iso-8859-1?Q?Ma/duv8Nbwfv0TGZob02fgBeXKQHIUWiClA8LdVfU/f/lXGA60oikNHG2b?=
 =?iso-8859-1?Q?ee+CwJmQMVnjPi9xgZz20dIQ8a7DldUHj5FzvU0qGWaDqGs5CzzfqLf8Ju?=
 =?iso-8859-1?Q?FYW0xwf1kurGe0ZppuMJrhjYyHBzzDxX8RXBNoFr5g9N8bNJVReYvmgOcJ?=
 =?iso-8859-1?Q?+pkP4B38azba3zxJReGRYasMrSBB0tEwLBpPZ4JTZK0SaXZ5EvU7RPTlcA?=
 =?iso-8859-1?Q?0enZxikcb0B/a/fRXmF4reSIvTLNNooe0Xyga9IT+l1Y+NCoW7yrQJbGGg?=
 =?iso-8859-1?Q?J+U79fUo+l4Ye683VqkQaiCD6/3DTqJBNdXa6sB01+Dsudy+Z+Sp4Tp6B+?=
 =?iso-8859-1?Q?KxMPGr3+wrx5pU/inELLdvhJxOXhZOiCpxvV+oEsi4288oUSiVWrYJHvgf?=
 =?iso-8859-1?Q?kbkDug6oRjr8du+STt3hXdL8YrWsPda4UV0CILijQ6FERx3Xb2lk6K3Eqk?=
 =?iso-8859-1?Q?wlPMwYsyICSZFG02l5MjtoOrijNVVDUzt+bcicWXd911j+glHdgjXRallB?=
 =?iso-8859-1?Q?brAiFjLd0zZALMfGWC2g7kJFoi3BsShCLGYaKyGEHnoJn3rxo3+NBSO7Up?=
 =?iso-8859-1?Q?KJgf+JrGE28YTPgMMsHezbkPO6p+vEUh+/5xXjznzfirhPh2Ges+2cAVGk?=
 =?iso-8859-1?Q?YK8Z4ECLb1NhuMgG4WASbwlbBsmYKvgq9ypo85ZcAuUK6lIb/JtBBLs0Jv?=
 =?iso-8859-1?Q?939FMDpXjCi+yuggeSe5WK6LpLmhUrYWdtn1D+QCJgmdmUKXfRvQpuXwyh?=
 =?iso-8859-1?Q?rnazbbldT0LQ5uGstKALV2Xj8PFA57n0jaiExuaE8sn/lTID8/0YIHHmag?=
 =?iso-8859-1?Q?2maBFdiFV3piRs5sZBAKdhdgbZMU9K+2GvVKR1bjoK0iqzaReU61c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1425.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XnuowDcEIYs810Oh5iwY6v8ZNyQ0ahGGZpU2Fs7uko70POsx0TeIPfHSO2?=
 =?iso-8859-1?Q?SWw5hOOCQ1D2lWsx/+Cto6cZf+oKAkLIrG0vjc8mSoBXOZ6sA9rxz5mr0o?=
 =?iso-8859-1?Q?PLp+EDHQeLdVUQft4UHqfQbPuWgLe2oz6lj+v7I7OuQwiCPcfuy2a/HAyF?=
 =?iso-8859-1?Q?vDTJdChM3Q3MsID5DFh7mI5KCiFgH3GFKtf1O0vHLv2II/X5IXqfzjL0Ni?=
 =?iso-8859-1?Q?AJnuxKhm9Vv4f4ePp6hRVAQFNkmbkoF4j7JP97gscg/Xz3CUJTh0RPQLmr?=
 =?iso-8859-1?Q?32saiepAedfYEL3GNDUqNfa+tkQ+eVLuyHtpm32dfUuhZPkagYJ6tC4r6R?=
 =?iso-8859-1?Q?klzbjzpxa3mEUspjk7qqJe3xIHnRCGy22nMmaMJfHZgPQubKTtqQp6aiq4?=
 =?iso-8859-1?Q?t/HMM0ri8JwJgIvi5nLNSODL1+DsMOjkMdLShI+e2waqwcpUlbDsgEUuI9?=
 =?iso-8859-1?Q?vuvPWem/mHIdUcKMUpQYWzRGx3Q+SkgTkDT0jhOOFwUcQj0LHQbL/lqiOW?=
 =?iso-8859-1?Q?HOpF3VSVN3j2h5Ey2KbT20VoNq4iaPKoh1yxiO7QwcHsOJxk/jd5oQIjjB?=
 =?iso-8859-1?Q?MWXR3KCsOhrwwWNUpoHWMrXWAwJRibx80zRN4/KM8uslUZCGU3r1NSmRUg?=
 =?iso-8859-1?Q?de1CQR4EFgSgi9r9h2t/TJ945IkjMSs4VulZgV6X426ZhA+8F/9rvk+xxu?=
 =?iso-8859-1?Q?KteimSsMn5mYZetAsL4HKOOFycvJfJUwIViwtveAjEo4w46gkf52L3cU5D?=
 =?iso-8859-1?Q?eYsuz4jDt/rdfS/s9preO1w0nA6YDqNYx/vCZPGnbXoG2cD14Dkek6vmgc?=
 =?iso-8859-1?Q?Sj2u6sKDzqhHpjrKERId+j7HejmBkihawwzJ2MPgHSFhug04AG6MYJDDi5?=
 =?iso-8859-1?Q?5iNHK7tmDqvDn7ie/i5wQUxUV4kJ0yvNfseoYjowMzayTLCSNmwDGwBl/T?=
 =?iso-8859-1?Q?jt3Kn6KhcqLA79PNh4TZjRI0QJgGMq3MAwbk/XgGAzntVSvQ61YnMqVG5X?=
 =?iso-8859-1?Q?PTZ/ogkR2VkySn2JkG3zaKeplaFrsz9WCDhjaoi/UJJt5cmhYetHk7MfSK?=
 =?iso-8859-1?Q?r2Z5OSGlfi+1gfLBxdCanunjJ38Uq1A7vCT96dGAQRRI1I/gyVm9TX7Lr1?=
 =?iso-8859-1?Q?YsZsGPimvDGeHltXyhEizaFk3r3fsX5EsKmOm75eCF+FO28AUIBrbI0Zc7?=
 =?iso-8859-1?Q?XyPVtbAJO0AB9bX4EwBNXwm8sAvMAiy+9dLZUoLivLroeneivOL3gzXy2c?=
 =?iso-8859-1?Q?syJZgotP2fJj/ZtbKR4MF+DyJCfnt8EbXUZgqdGMjWBnEBGoFanGO59yjE?=
 =?iso-8859-1?Q?4oHJAx8cXHvJ1//M2lC3LPr51X1wbwU1/i9x673pvHvaEJ2F4/h60r7fdH?=
 =?iso-8859-1?Q?6oxR9aPOUagfpoi1z4jFJKLZmxXYau+dtd/0m0NGRDP4RKhGsx7RVjzHMe?=
 =?iso-8859-1?Q?Jnt9b0z4X4ffyeC1/LUOnBx42lzUjhq16hUfU5FUgPwnE8OHGVE1zXak+U?=
 =?iso-8859-1?Q?kKMT0p4PWxbK4Yp/RX4f/2fHTea7DnFqHntLlpM9HqgiYyuAq0yvODsrGV?=
 =?iso-8859-1?Q?2mtx+7u7363blJKUyQwBNsPjk/9j?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: owlcyberdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1425.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ea27cd-5235-46fb-496d-08dcfa7cc0fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 13:54:49.9926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0c7a5d8a-53f7-44d2-b6c9-63bab40ba995
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1507

Hello,=0A=
=0A=
I'm working on addressing some performance issues that we have noticed with=
 setrans. Overall, I'm making good progress and hope to be able to submit s=
ome patches to that effect in the future.=0A=
=0A=
I'm writing now to clarify the desired behavior of trans_context().=0A=
=0A=
1) It is currently possible to have some modifier words set a category c1, =
and have other modifier words unset the same category. Using this (and the =
ability for modifier words to set multiple categories at once), you can cre=
ate a config that makes computing translations a pretty complicated puzzle.=
 The current implementation does not handle this situation well. I'm wonder=
ing if it would be okay to simply forbid this situation?=0A=
    =0A=
2) Since modifier words can effect multiple categories, it is possible that=
 the selection of words is ambigous. The current approach to this is to rou=
ghly to greedily follow the below rules:=0A=
 - Select the word which results in use being the closest to the desired le=
vel.=0A=
 - If there are multiple such words, select the one which was defined first=
.=0A=
 If you look at the nato example, these heuristics mean that it is importan=
t that rel.conf be included before eyes-only.conf. Otherwise, you would sel=
ect a single word from rel because of c200, then pick the rest of the words=
 from eyes-only.=0A=
There are two changes I am planning on making regarding this:=0A=
  - Select a word based on how much it differs from the base classification=
 in use. This way words still get "credit" for (un)setting a category, even=
 if another word has done so. This would make the nato example work regardl=
ess of what order rel.conf and eyes-only.conf are included.=0A=
  - Iterate through categories sequentially and select words from the set t=
hat fixes the category we are looking at. This change is being done purely =
for reasons of efficiency. It is possible to construct a configuration wher=
e this gives a different result from selecting from the set of words that f=
ixes any category, but I think the configs that do so are rather contrived.=
=0A=
=0A=
3) Once the base classification and words are selected, the order they are =
displayed in is never explicitly defined. I'm planning on making them be di=
splayed in the order in which they were defined in the config.=0A=
=0A=
Are there any questions or concerns with any of these decisions before I go=
 too far down this rabbit hole?=0A=
=0A=
Thanks,=0A=
Brandon=
